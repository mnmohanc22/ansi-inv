def setup_logger():
    logger = logging.getLogger('AUDIT_ENRICHED')
    logger.setLevel(logging.INFO)
    logger.propagate = False
    address = '/dev/log' if os.path.exists('/dev/log') else ('localhost', 514)
    handler = logging.handlers.SysLogHandler(
        address=address,
        facility=logging.handlers.SysLogHandler.LOG_LOCAL3,
        socktype=socket.SOCK_DGRAM
    )
    handler.setLevel(logging.INFO)
    handler.ident = 'AUDIT_ENRICHED: '
    logger.addHandler(handler)
    return logger

#!/usr/bin/env python3 -u
# /opt/scripts/audit_enrich_simple.py
#
# Reads ALL audit records from stdin (audisp pipe)
# No subtype checking — treats every record identically
# Stamps AWS metadata on every record
# Writes JSON to /var/log/audit-enriched.log via rsyslog
#
# Plugin config: /etc/audit/plugins.d/audit_enrich_simple.conf
#   active    = yes
#   direction = out
#   path      = /usr/bin/python3
#   args      = -u /opt/scripts/audit_enrich_simple.py
#   type      = always
#   format    = string

import sys
import io
import os
import re
import json
import logging
import logging.handlers
import socket
import urllib.request
from datetime import datetime, timezone


# ─────────────────────────────────────────────────────────────
# SECTION 1 — AWS Metadata (fetched once at startup)
# ─────────────────────────────────────────────────────────────

def fetch_aws_metadata():
    """
    Fetch EC2 instance metadata once at startup.
    Cached in memory — zero HTTP calls per audit record.
    Returns safe defaults if not running on EC2.
    """

    defaults = {
        'aws_instance_id'   : 'not-ec2',
        'aws_instance_type' : 'unknown',
        'aws_region'        : 'unknown',
        'aws_az'            : 'unknown',
        'aws_account_id'    : 'unknown',
        'aws_vpc_id'        : 'unknown',
        'aws_private_ip'    : 'unknown',
        'aws_iam_role'      : 'unknown',
    }

    try:
        # IMDSv2 token
        token = None
        try:
            req = urllib.request.Request(
                'http://169.254.169.254/latest/api/token',
                method='PUT',
                headers={'X-aws-ec2-metadata-token-ttl-seconds': '21600'}
            )
            with urllib.request.urlopen(req, timeout=2) as r:
                token = r.read().decode().strip()
        except Exception:
            pass

        headers = {'X-aws-ec2-metadata-token': token} if token else {}

        def get(path):
            try:
                req = urllib.request.Request(
                    f'http://169.254.169.254/latest/{path}',
                    headers=headers
                )
                with urllib.request.urlopen(req, timeout=2) as r:
                    return r.read().decode().strip()
            except Exception:
                return ''

        # Identity document — single call returns most fields
        doc = get('dynamic/instance-identity/document')
        identity = json.loads(doc) if doc else {}

        if not identity:
            return defaults

        # VPC id via mac
        mac    = get('meta-data/network/interfaces/macs/').split('\n')[0].strip('/')
        vpc_id = get(f'meta-data/network/interfaces/macs/{mac}/vpc-id') if mac else 'unknown'

        # IAM role
        role_path = get('meta-data/iam/security-credentials/')
        iam_role  = role_path.split('\n')[0] if role_path else 'unknown'

        return {
            'aws_instance_id'   : identity.get('instanceId',        'unknown'),
            'aws_instance_type' : identity.get('instanceType',       'unknown'),
            'aws_region'        : identity.get('region',             'unknown'),
            'aws_az'            : identity.get('availabilityZone',   'unknown'),
            'aws_account_id'    : identity.get('accountId',          'unknown'),
            'aws_vpc_id'        : vpc_id or 'unknown',
            'aws_private_ip'    : identity.get('privateIp',          'unknown'),
            'aws_iam_role'      : iam_role or 'unknown',
        }

    except Exception as e:
        defaults['aws_fetch_error'] = str(e)
        return defaults


# ─────────────────────────────────────────────────────────────
# SECTION 2 — Logger Setup
# Writes to /var/log/audit-enriched.log via rsyslog LOCAL3
# ─────────────────────────────────────────────────────────────

def setup_logger():
    logger = logging.getLogger('AUDIT_ENRICHED')
    logger.setLevel(logging.INFO)
    logger.propagate = False

    address = '/dev/log' if os.path.exists('/dev/log') else ('localhost', 514)

    handler = logging.handlers.SysLogHandler(
        address=address,
        facility=logging.handlers.SysLogHandler.LOG_LOCAL3,
        socktype=socket.SOCK_DGRAM
    )
    handler.setLevel(logging.INFO)
    handler.ident = 'AUDIT_ENRICHED: '
    logger.addHandler(handler)
    return logger


# ─────────────────────────────────────────────────────────────
# SECTION 3 — Parser
# No subtype logic — parses every record identically
# ─────────────────────────────────────────────────────────────

def parse_record(line):
    """
    Parse any audit record into a flat dict.
    No subtype-specific handling — treats all records the same.

    Extracts:
      - type=           audit record type (kept as-is, not acted on)
      - msg=audit(...)  epoch and serial number
      - all key=value   outer fields
      - msg='...'       inner PAM fields prefixed with pam_
    """

    record = {'raw': line.strip()}

    # type= field
    m = re.match(r'^type=(\S+)', line)
    if m:
        record['type'] = m.group(1)

    # audit(EPOCH:SERIAL)
    m = re.search(r'msg=audit\((\d+\.\d+):(\d+)\)', line)
    if m:
        record['audit_epoch']  = m.group(1)
        record['audit_serial'] = m.group(2)

    # inner msg='...' PAM content
    m = re.search(r"msg='([^']+)'", line)
    if m:
        for kv in re.finditer(
            r'(\w+)=("([^"]*)"|(\'([^\']*)\')|([^\s]+))',
            m.group(1)
        ):
            key = kv.group(1)
            val = kv.group(6) or kv.group(3) or kv.group(5) or ''
            record[f'pam_{key}'] = val

    # all outer key=value pairs
    for kv in re.finditer(
        r'(\w+)=("([^"]*)"|(\'([^\']*)\')|([^\s]+))',
        line
    ):
        key = kv.group(1)
        if key in ('type', 'msg'):
            continue
        val = kv.group(6) or kv.group(3) or kv.group(5) or ''
        record[key] = val

    return record


# ─────────────────────────────────────────────────────────────
# SECTION 4 — Enrichment
# Stamps AWS metadata + static fields on every record
# ─────────────────────────────────────────────────────────────

def enrich(record, aws_meta, static_fields):
    """
    Merge parsed audit fields with AWS metadata and static fields.
    No subtype logic — same enrichment applied to every record.
    """

    enriched = {}

    # Timestamp
    enriched['@timestamp'] = datetime.now(timezone.utc).isoformat()

    # Static site fields
    enriched.update(static_fields)

    # AWS metadata — stamped on every record
    enriched.update(aws_meta)

    # All parsed audit fields
    enriched.update(record)

    return enriched


# ─────────────────────────────────────────────────────────────
# SECTION 5 — Main Loop
# ─────────────────────────────────────────────────────────────

def main():

    logger = setup_logger()

    # Fetch AWS metadata once — cached for entire run
    aws_meta = fetch_aws_metadata()

    static_fields = {
        'env'        : 'production',
        'team'       : 'iam-middleware',
        'datacenter' : f"aws-{aws_meta.get('aws_region', 'unknown')}",
        'log_source' : 'auditd-enriched',
        'host'       : socket.gethostname(),
    }

    # Log startup confirmation to /var/log/audit-enriched.log
    logger.info(json.dumps({
        '@timestamp'      : datetime.now(timezone.utc).isoformat(),
        'event_type'      : 'ENRICHER_START',
        'aws_instance_id' : aws_meta.get('aws_instance_id'),
        'aws_region'      : aws_meta.get('aws_region'),
        'message'         : 'pipeline started'
    }))

    # Force line-buffered stdin
    sys.stdin = io.TextIOWrapper(
        sys.stdin.buffer,
        line_buffering=True,
        encoding='utf-8',
        errors='replace'
    )

    # Main read loop — one audit record per line
    for line in sys.stdin:

        line = line.strip()
        if not line:
            continue

        try:
            record   = parse_record(line)
            enriched = enrich(record, aws_meta, static_fields)
            logger.info(json.dumps(enriched, ensure_ascii=False))

        except Exception as exc:
            try:
                logger.error(json.dumps({
                    '@timestamp' : datetime.now(timezone.utc).isoformat(),
                    'event_type' : 'ENRICH_ERROR',
                    'error'      : str(exc),
                    'raw'        : line[:300],
                }))
            except Exception:
                pass
            continue


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(0)