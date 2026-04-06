#!/usr/bin/env python3
"""
audit_log_enrich.py
====================
Enrich auditd log output with AWS EC2 context.

Responsibilities (this script ONLY):
  - Load AWS metadata from the JSON cache written by aws_metadata_fetch.py
  - Parse raw auditd log lines into structured fields
  - Merge AWS context fields into every parsed record
  - Expose multiple output modes: text, JSON, live tail, ausearch wrapper

This script does NOT contact IMDS — it relies entirely on the JSON cache.
Run aws_metadata_fetch.py first (or schedule it via cron / systemd).

Stdlib only — no pip installs required.

Usage:
  python3 audit_log_enrich.py --show                       # print AWS context banner
  python3 audit_log_enrich.py --ausearch -- -m USER_AUTH   # ausearch wrapper
  python3 audit_log_enrich.py --tail                       # live tail (text)
  python3 audit_log_enrich.py --tail --json-output         # live tail (JSON → SIEM)
  python3 audit_log_enrich.py --parse-log /var/log/audit/audit.log

Exit codes:
  0  success / normal operation
  1  JSON cache missing or unreadable
  2  audit log not found (--tail / --parse-log)


Target : RHEL 8 / AWS EC2 / NIST 800-53 / IRS 1075
"""

import argparse
import json
import logging
import re
import subprocess
import sys
import time
from dataclasses import dataclass, field, asdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

# ---------------------------------------------------------------------------
# Defaults (overridable via CLI / Ansible-rendered config)
# ---------------------------------------------------------------------------
DEFAULT_JSON_CACHE = Path("/var/log/audit/aws_metadata.json")
DEFAULT_AUDIT_LOG  = Path("/var/log/audit/audit.log")

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [audit-log-enrich] %(levelname)s %(message)s",
    datefmt="%Y-%m-%dT%H:%M:%S",
)
log = logging.getLogger("audit-log-enrich")


# ---------------------------------------------------------------------------
# Metadata model (mirrors aws_metadata_fetch.EC2Metadata — no IMDS code)
# ---------------------------------------------------------------------------
def _utcnow() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


@dataclass
class EC2Metadata:
    instance_id:       str = "unknown"
    instance_type:     str = "unknown"
    region:            str = "unknown"
    availability_zone: str = "unknown"
    local_ipv4:        str = "unknown"
    public_ipv4:       str = "none"
    hostname:          str = "unknown"
    account_id:        str = "unknown"
    image_id:          str = "unknown"
    iam_role:          str = "none"
    refreshed_at:      str = field(default_factory=_utcnow)

    def banner(self) -> str:
        sep = "=" * 66
        rows = [
            sep,
            "  AWS EC2 AUDIT CONTEXT",
            sep,
            f"  Instance ID   : {self.instance_id}",
            f"  Instance Type : {self.instance_type}",
            f"  Region        : {self.region}",
            f"  AZ            : {self.availability_zone}",
            f"  Account ID    : {self.account_id}",
            f"  Image ID      : {self.image_id}",
            f"  Local IP      : {self.local_ipv4}",
            f"  Public IP     : {self.public_ipv4}",
            f"  Hostname      : {self.hostname}",
            f"  IAM Role      : {self.iam_role}",
            f"  Metadata Age  : {self.refreshed_at}",
            sep,
        ]
        return "\n".join(rows)

    def as_enrich_dict(self) -> dict:
        """Flat dict of AWS fields injected into every enriched record."""
        return {
            "aws_instance_id":    self.instance_id,
            "aws_instance_type":  self.instance_type,
            "aws_region":         self.region,
            "aws_az":             self.availability_zone,
            "aws_account_id":     self.account_id,
            "aws_image_id":       self.image_id,
            "aws_local_ip":       self.local_ipv4,
            "aws_public_ip":      self.public_ipv4,
            "aws_hostname":       self.hostname,
            "aws_iam_role":       self.iam_role,
            "aws_metadata_ts":    self.refreshed_at,
        }


# ---------------------------------------------------------------------------
# JSON cache loader
# ---------------------------------------------------------------------------
def load_metadata(cache_path: Path) -> EC2Metadata:
    """
    Load EC2Metadata from the JSON cache written by aws_metadata_fetch.py.
    Raises FileNotFoundError or ValueError on problems.
    """
    if not cache_path.exists():
        raise FileNotFoundError(
            f"Metadata JSON cache not found: {cache_path}\n"
            "Run 'aws_metadata_fetch.py' first to populate the cache."
        )
    try:
        data = json.loads(cache_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise ValueError(f"Corrupt JSON cache ({cache_path}): {exc}") from exc

    return EC2Metadata(**{k: v for k, v in data.items() if k in EC2Metadata.__dataclass_fields__})


# ---------------------------------------------------------------------------
# auditd log parser
# ---------------------------------------------------------------------------

# Compiled patterns — match common auditd record fields
_RE_TYPE    = re.compile(r'\btype=(\S+)')
_RE_MSG_TS  = re.compile(r'msg=audit\((\d+\.\d+):(\d+)\)')
_RE_SYSCALL = re.compile(r'\bsyscall=(\d+)')
_RE_UID     = re.compile(r'\buid=(\d+)')
_RE_EUID    = re.compile(r'\beuid=(\d+)')
_RE_AUID    = re.compile(r'\bauid=(\d+)')
_RE_GID     = re.compile(r'\bgid=(\d+)')
_RE_EGID    = re.compile(r'\begid=(\d+)')
_RE_PID     = re.compile(r'\bpid=(\d+)')
_RE_PPID    = re.compile(r'\bppid=(\d+)')
_RE_COMM    = re.compile(r'\bcomm="?([^"\s]+)"?')
_RE_EXE     = re.compile(r'\bexe="([^"]+)"')
_RE_KEY     = re.compile(r'\bkey="?([^"\s]+)"?')
_RE_RES     = re.compile(r'\bres=(\S+)')
_RE_SUBJ    = re.compile(r'\bsubj=(\S+)')
_RE_ARCH    = re.compile(r'\barch=(\S+)')
_RE_SUCCESS = re.compile(r'\bsuccess=(\S+)')
_RE_EXIT    = re.compile(r'\bexit=(-?\d+)')
_RE_ADDR    = re.compile(r'\baddr=(\S+)')
_RE_HOSTNAME= re.compile(r'\bhostname=(\S+)')
_RE_TERMINAL= re.compile(r'\bterminal=(\S+)')
_RE_OBJ     = re.compile(r'\bobj=(\S+)')
_RE_NAMETYPE= re.compile(r'\bnametype=(\S+)')


def _ex(pattern: re.Pattern, line: str, default: str = "-") -> str:
    """Extract first capture group or return default."""
    m = pattern.search(line)
    return m.group(1) if m else default


def _epoch_to_iso(ts_str: str) -> str:
    try:
        return datetime.fromtimestamp(float(ts_str), tz=timezone.utc).isoformat(timespec="milliseconds")
    except (ValueError, OSError):
        return ts_str


def parse_audit_line(line: str) -> dict:
    """
    Parse a single raw auditd log line into a structured dict.
    All fields present regardless of whether they appear in the line (default '-').
    """
    line = line.rstrip()
    ts_raw = _ex(_RE_MSG_TS, line)
    return {
        # --- timing ---
        "timestamp":    _epoch_to_iso(ts_raw) if ts_raw != "-" else _utcnow(),
        "epoch_ts":     ts_raw,
        # --- record identity ---
        "audit_type":   _ex(_RE_TYPE,    line),
        "arch":         _ex(_RE_ARCH,    line),
        "syscall":      _ex(_RE_SYSCALL, line),
        "success":      _ex(_RE_SUCCESS, line),
        "exit_code":    _ex(_RE_EXIT,    line),
        # --- subject ---
        "uid":          _ex(_RE_UID,     line),
        "euid":         _ex(_RE_EUID,    line),
        "auid":         _ex(_RE_AUID,    line),
        "gid":          _ex(_RE_GID,     line),
        "egid":         _ex(_RE_EGID,    line),
        "pid":          _ex(_RE_PID,     line),
        "ppid":         _ex(_RE_PPID,    line),
        "subj":         _ex(_RE_SUBJ,    line),
        # --- process ---
        "comm":         _ex(_RE_COMM,    line),
        "exe":          _ex(_RE_EXE,     line),
        # --- object ---
        "obj":          _ex(_RE_OBJ,     line),
        "nametype":     _ex(_RE_NAMETYPE,line),
        # --- network / terminal ---
        "addr":         _ex(_RE_ADDR,    line),
        "audit_host":   _ex(_RE_HOSTNAME,line),
        "terminal":     _ex(_RE_TERMINAL,line),
        # --- rule match ---
        "key":          _ex(_RE_KEY,     line),
        "result":       _ex(_RE_RES,     line),
        # --- raw ---
        "raw":          line,
    }


def enrich_record(parsed: dict, meta: EC2Metadata) -> dict:
    """Merge AWS metadata fields into a parsed audit record."""
    return {**parsed, **meta.as_enrich_dict()}


def enrich_line(line: str, meta: EC2Metadata) -> dict:
    """One-shot helper: parse + enrich a raw log line."""
    return enrich_record(parse_audit_line(line), meta)


# ---------------------------------------------------------------------------
# Output formatters
# ---------------------------------------------------------------------------

def _fmt_text(record: dict) -> str:
    return (
        f"[{record['timestamp']}] "
        f"type={record['audit_type']} "
        f"key={record['key']} "
        f"uid={record['uid']} euid={record['euid']} auid={record['auid']} "
        f"comm={record['comm']} "
        f"success={record['success']} "
        f"instance={record['aws_instance_id']} "
        f"region={record['aws_region']} "
        f"account={record['aws_account_id']}"
    )


def _emit(record: dict, *, as_json: bool) -> None:
    if as_json:
        print(json.dumps(record), flush=True)
    else:
        print(_fmt_text(record), flush=True)


# ---------------------------------------------------------------------------
# Operational modes
# ---------------------------------------------------------------------------

def parse_log_file(log_path: Path, meta: EC2Metadata, *, as_json: bool = True) -> None:
    """Enrich every line in a saved audit log file."""
    if not log_path.exists():
        log.error("Log file not found: %s", log_path)
        sys.exit(2)
    log.info("Parsing %s …", log_path)
    with log_path.open("r", errors="replace") as fh:
        for line in fh:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            _emit(enrich_line(line, meta), as_json=as_json)


def tail_log(log_path: Path, meta: EC2Metadata, *, as_json: bool = False) -> None:
    """Live-tail audit.log, enriching each new line as it arrives."""
    if not log_path.exists():
        log.error("Audit log not found: %s", log_path)
        sys.exit(2)
    log.info("Tailing %s — Ctrl-C to stop", log_path)
    print(meta.banner())
    print()
    with log_path.open("r", errors="replace") as fh:
        fh.seek(0, 2)           # start from end
        while True:
            line = fh.readline()
            if not line:
                time.sleep(0.2)
                continue
            _emit(enrich_line(line, meta), as_json=as_json)


def run_ausearch(meta: EC2Metadata, ausearch_args: list) -> None:
    """Print AWS context banner then exec ausearch."""
    print(meta.banner())
    print()
    cmd = ["ausearch"] + [a for a in ausearch_args if a != "--"]
    log.info("Executing: %s", " ".join(cmd))
    try:
        result = subprocess.run(cmd, check=False)
        sys.exit(result.returncode)
    except FileNotFoundError:
        log.error("ausearch not found — install the 'audit' package")
        sys.exit(1)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="audit_log_enrich.py",
        description=(
            "Enrich auditd log output with AWS EC2 context loaded from the "
            "JSON cache produced by aws_metadata_fetch.py."
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Show AWS context banner
  sudo python3 audit_log_enrich.py --show

  # Live tail (human-readable)
  sudo python3 audit_log_enrich.py --tail

  # Live tail → JSON stream for Splunk / Elastic
  sudo python3 audit_log_enrich.py --tail --json-output

  # Parse a saved log → one JSON record per line
  sudo python3 audit_log_enrich.py --parse-log /var/log/audit/audit.log

  # ausearch wrapper with AWS context header
  sudo python3 audit_log_enrich.py --ausearch -- -m USER_AUTH --success no -i
        """,
    )

    mode = p.add_mutually_exclusive_group(required=True)
    mode.add_argument("--show",      action="store_true", help="Print AWS context banner and exit.")
    mode.add_argument("--tail",      action="store_true", help="Live-tail audit.log with enrichment.")
    mode.add_argument("--parse-log", metavar="FILE",      help="Enrich a saved audit log file.")
    mode.add_argument(
        "--ausearch", nargs=argparse.REMAINDER, metavar="ARGS",
        help="Print AWS banner then exec ausearch with remaining args.",
    )

    p.add_argument(
        "--json-output", action="store_true", default=False,
        help="Emit JSON records (for --tail and --parse-log).",
    )
    p.add_argument(
        "--json-cache",
        default=str(DEFAULT_JSON_CACHE),
        metavar="PATH",
        help=f"Path to JSON metadata cache (default: {DEFAULT_JSON_CACHE}).",
    )
    p.add_argument(
        "--audit-log",
        default=str(DEFAULT_AUDIT_LOG),
        metavar="PATH",
        help=f"Audit log path for --tail (default: {DEFAULT_AUDIT_LOG}).",
    )
    p.add_argument("--debug", action="store_true", help="Enable debug-level logging.")
    return p


def main() -> None:
    args = build_parser().parse_args()
    if args.debug:
        logging.getLogger().setLevel(logging.DEBUG)

    cache_path = Path(args.json_cache)
    try:
        meta = load_metadata(cache_path)
    except (FileNotFoundError, ValueError) as exc:
        log.error("%s", exc)
        sys.exit(1)

    if args.show:
        print(meta.banner())
        return

    if args.tail:
        try:
            tail_log(Path(args.audit_log), meta, as_json=args.json_output)
        except KeyboardInterrupt:
            print("\nStopped.")
        return

    if args.parse_log:
        parse_log_file(Path(args.parse_log), meta, as_json=args.json_output)
        return

    if args.ausearch is not None:
        run_ausearch(meta, args.ausearch)
        return


if __name__ == "__main__":
    main()
