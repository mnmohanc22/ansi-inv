#!/usr/bin/env python3
"""
aws_metadata_fetch.py
======================
Fetch AWS EC2 instance metadata via IMDSv2 and persist it locally.

Responsibilities (this script ONLY):
  - Acquire IMDSv2 session token
  - Fetch all required metadata fields from the IMDS endpoint
  - Write a shell-sourceable KEY=value env file  (for auditd/audisp pipelines)
  - Write a JSON cache file                       (consumed by audit_log_enrich.py)
  - Exit non-zero on any IMDS failure so callers / systemd can react

This script has NO audit log parsing logic — see audit_log_enrich.py.

Stdlib only — no pip installs required.

Usage:
  python3 aws_metadata_fetch.py                        # write env + JSON
  python3 aws_metadata_fetch.py --show                 # print banner to stdout
  python3 aws_metadata_fetch.py --json                 # print JSON to stdout
  python3 aws_metadata_fetch.py --env-file /custom/path.env
  python3 aws_metadata_fetch.py --json-cache /custom/path.json
  python3 aws_metadata_fetch.py --debug

Exit codes:
  0  success
  1  IMDS unreachable / not an EC2 instance
  2  I/O error writing output files


Target : RHEL 8 / AWS EC2 / NIST 800-53 / IRS 1075
"""

import argparse
import json
import logging
import os
import sys
import time
import urllib.error
import urllib.request
from dataclasses import asdict, dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

# ---------------------------------------------------------------------------
# Defaults (overridable via CLI args or Ansible-rendered config)
# ---------------------------------------------------------------------------
IMDS_TOKEN_URL   = "http://169.254.169.254/latest/api/token"
IMDS_BASE_URL    = "http://169.254.169.254/latest/meta-data"
IMDS_IDENTITY_URL = "http://169.254.169.254/latest/dynamic/instance-identity/document"
IMDS_TOKEN_TTL   = "21600"
IMDS_TIMEOUT     = 3      # seconds per HTTP request
IMDS_RETRIES     = 3

DEFAULT_ENV_FILE   = Path("/var/log/audit/aws_metadata.env")
DEFAULT_JSON_CACHE = Path("/var/log/audit/aws_metadata.json")

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [aws-metadata-fetch] %(levelname)s %(message)s",
    datefmt="%Y-%m-%dT%H:%M:%S",
)
log = logging.getLogger("aws-metadata-fetch")


# ---------------------------------------------------------------------------
# Data model
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

    # ------------------------------------------------------------------
    def as_env_dict(self) -> dict:
        """Return uppercase KEY=value mapping for shell env file."""
        return {
            "AWS_INSTANCE_ID":   self.instance_id,
            "AWS_INSTANCE_TYPE": self.instance_type,
            "AWS_REGION":        self.region,
            "AWS_AZ":            self.availability_zone,
            "AWS_LOCAL_IP":      self.local_ipv4,
            "AWS_PUBLIC_IP":     self.public_ipv4,
            "AWS_HOSTNAME":      self.hostname,
            "AWS_ACCOUNT_ID":    self.account_id,
            "AWS_IMAGE_ID":      self.image_id,
            "AWS_IAM_ROLE":      self.iam_role,
            "AWS_METADATA_TS":   self.refreshed_at,
        }

    def as_json(self, indent: int = 2) -> str:
        return json.dumps(asdict(self), indent=indent)

    def banner(self) -> str:
        sep = "=" * 66
        rows = [
            sep,
            "  AWS EC2 INSTANCE METADATA",
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
            f"  Refreshed At  : {self.refreshed_at}",
            sep,
        ]
        return "\n".join(rows)


# ---------------------------------------------------------------------------
# IMDSv2 HTTP client
# ---------------------------------------------------------------------------
class IMDSv2Client:
    """
    Minimal IMDSv2-only client.
    All requests carry the session token header; no IMDSv1 fallback.
    """

    def __init__(self, timeout: int = IMDS_TIMEOUT, retries: int = IMDS_RETRIES):
        self.timeout  = timeout
        self.retries  = retries
        self._token: Optional[str] = None

    # --- token acquisition --------------------------------------------------
    def get_token(self) -> str:
        if self._token:
            return self._token

        req = urllib.request.Request(
            IMDS_TOKEN_URL,
            method="PUT",
            headers={"X-aws-ec2-metadata-token-ttl-seconds": IMDS_TOKEN_TTL},
        )
        last_exc: Exception = RuntimeError("No attempts made")
        for attempt in range(1, self.retries + 1):
            try:
                with urllib.request.urlopen(req, timeout=self.timeout) as resp:
                    self._token = resp.read().decode().strip()
                    log.debug("IMDSv2 token acquired (attempt %d)", attempt)
                    return self._token
            except (urllib.error.URLError, OSError) as exc:
                last_exc = exc
                log.debug("Token fetch attempt %d/%d failed: %s", attempt, self.retries, exc)
                if attempt < self.retries:
                    time.sleep(0.5 * attempt)

        raise RuntimeError(
            f"IMDSv2 token unavailable after {self.retries} attempts: {last_exc}\n"
            "Ensure this host is an EC2 instance and IMDSv2 is enabled "
            "(check instance metadata options)."
        ) from last_exc

    # --- generic GET --------------------------------------------------------
    def _get(self, url: str, *, allow_404: bool = False) -> Optional[str]:
        token = self.get_token()
        headers = {"X-aws-ec2-metadata-token": token}
        for attempt in range(1, self.retries + 1):
            try:
                req = urllib.request.Request(url, headers=headers)
                with urllib.request.urlopen(req, timeout=self.timeout) as resp:
                    return resp.read().decode().strip()
            except urllib.error.HTTPError as exc:
                if exc.code == 404 and allow_404:
                    return None
                log.debug("HTTP %s from %s (attempt %d/%d)", exc.code, url, attempt, self.retries)
            except (urllib.error.URLError, OSError) as exc:
                log.debug("Error fetching %s (attempt %d/%d): %s", url, attempt, self.retries, exc)
            if attempt < self.retries:
                time.sleep(0.5 * attempt)
        return None

    def get(self, path: str, *, allow_404: bool = False) -> Optional[str]:
        return self._get(f"{IMDS_BASE_URL}/{path.lstrip('/')}", allow_404=allow_404)

    def get_identity_document(self) -> dict:
        raw = self._get(IMDS_IDENTITY_URL)
        if not raw:
            log.warning("Identity document unavailable; account_id / image_id will be unknown")
            return {}
        try:
            return json.loads(raw)
        except json.JSONDecodeError as exc:
            log.warning("Failed to parse identity document: %s", exc)
            return {}


# ---------------------------------------------------------------------------
# Fetch orchestration
# ---------------------------------------------------------------------------
def fetch_metadata(client: Optional[IMDSv2Client] = None) -> EC2Metadata:
    """
    Fetch all EC2 metadata fields via IMDSv2 and return an EC2Metadata instance.
    Raises RuntimeError if IMDS is unreachable.
    """
    if client is None:
        client = IMDSv2Client()

    log.info("Acquiring IMDSv2 token …")
    client.get_token()
    log.info("Token OK — fetching metadata fields …")

    identity = client.get_identity_document()

    # IAM instance profile role (optional — absent on instances without a profile)
    iam_listing = client.get("iam/security-credentials/", allow_404=True)
    iam_role    = iam_listing.splitlines()[0].strip() if iam_listing else "none"

    meta = EC2Metadata(
        instance_id       = client.get("instance-id")                 or "unknown",
        instance_type     = client.get("instance-type")               or "unknown",
        availability_zone = client.get("placement/availability-zone") or "unknown",
        region            = client.get("placement/region")            or identity.get("region", "unknown"),
        local_ipv4        = client.get("local-ipv4")                  or "unknown",
        public_ipv4       = client.get("public-ipv4", allow_404=True) or "none",
        hostname          = client.get("hostname")                    or "unknown",
        account_id        = identity.get("accountId", "unknown"),
        image_id          = identity.get("imageId",   "unknown"),
        iam_role          = iam_role,
        refreshed_at      = _utcnow(),
    )

    log.info(
        "Metadata complete — instance=%s  type=%s  region=%s  az=%s  account=%s",
        meta.instance_id, meta.instance_type, meta.region,
        meta.availability_zone, meta.account_id,
    )
    return meta


# ---------------------------------------------------------------------------
# Output writers
# ---------------------------------------------------------------------------
def _ensure_dir(path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)


def write_env_file(meta: EC2Metadata, path: Path) -> None:
    """Write shell-sourceable KEY=value env file (mode 0640)."""
    _ensure_dir(path)
    lines = [
        "# AWS EC2 Instance Metadata",
        "# Written by aws_metadata_fetch.py — do not edit manually",
        f"# Refreshed: {meta.refreshed_at}",
        "",
    ]
    for key, val in meta.as_env_dict().items():
        lines.append(f"{key}={val}")
    lines.append("")
    path.write_text("\n".join(lines), encoding="utf-8")
    os.chmod(path, 0o640)
    log.info("Env file written  → %s", path)


def write_json_cache(meta: EC2Metadata, path: Path) -> None:
    """Write JSON cache file consumed by audit_log_enrich.py (mode 0640)."""
    _ensure_dir(path)
    path.write_text(meta.as_json(), encoding="utf-8")
    os.chmod(path, 0o640)
    log.info("JSON cache written → %s", path)


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------
def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="aws_metadata_fetch.py",
        description=(
            "Fetch AWS EC2 instance metadata via IMDSv2 and write an env file "
            "and JSON cache for use by audit_log_enrich.py."
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Normal run (cron / systemd) — writes both output files
  sudo python3 aws_metadata_fetch.py

  # Print human-readable banner only (no file writes)
  sudo python3 aws_metadata_fetch.py --show

  # Print JSON to stdout (no file writes) — useful for piping to jq
  sudo python3 aws_metadata_fetch.py --json

  # Custom output paths
  sudo python3 aws_metadata_fetch.py \\
      --env-file /etc/audit/aws_context.env \\
      --json-cache /run/audit/aws_metadata.json
        """,
    )

    p.add_argument(
        "--env-file",
        default=str(DEFAULT_ENV_FILE),
        metavar="PATH",
        help=f"Destination for shell env file (default: {DEFAULT_ENV_FILE})",
    )
    p.add_argument(
        "--json-cache",
        default=str(DEFAULT_JSON_CACHE),
        metavar="PATH",
        help=f"Destination for JSON cache file (default: {DEFAULT_JSON_CACHE})",
    )
    p.add_argument(
        "--show",
        action="store_true",
        help="Print metadata banner to stdout instead of writing files.",
    )
    p.add_argument(
        "--json",
        action="store_true",
        help="Print metadata as JSON to stdout instead of writing files.",
    )
    p.add_argument(
        "--debug",
        action="store_true",
        help="Enable debug-level logging.",
    )
    return p


def main() -> None:
    args = build_parser().parse_args()

    if args.debug:
        logging.getLogger().setLevel(logging.DEBUG)

    try:
        meta = fetch_metadata()
    except RuntimeError as exc:
        log.error("%s", exc)
        sys.exit(1)

    if args.show:
        print(meta.banner())
        return

    if args.json:
        print(meta.as_json())
        return

    # Default: write both files
    try:
        write_env_file(meta, Path(args.env_file))
        write_json_cache(meta, Path(args.json_cache))
    except OSError as exc:
        log.error("Failed to write output file: %s", exc)
        sys.exit(2)

    log.info("Done.")


if __name__ == "__main__":
    main()
