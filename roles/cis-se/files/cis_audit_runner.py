#!/usr/bin/env python3
"""
Parse Tenable .audit file, run all CMD_EXEC checks, write results to CSV.

CSV columns: hostname, cis_id, description, result, output

Usage:
    python3 cis_audit_runner.py <audit_file> <output_csv>
"""

import csv
import re
import socket
import subprocess
import sys


EXPECT_PASS_RE = re.compile(r'(?i)^\s*\**\s*pass:?\s*\**\s*$', re.MULTILINE)
CMD_TIMEOUT = 60


def unescape(s):
    """Unescape Tenable audit format: \\\" -> \" and \\\\ -> \\"""
    out = []
    i = 0
    while i < len(s):
        if s[i] == '\\' and i + 1 < len(s):
            nxt = s[i + 1]
            if nxt == '"':
                out.append('"')
            elif nxt == '\\':
                out.append('\\')
            elif nxt == 'n':
                out.append('\n')
            elif nxt == 't':
                out.append('\t')
            else:
                out.append('\\')
                out.append(nxt)
            i += 2
        else:
            out.append(s[i])
            i += 1
    return ''.join(out)


def extract_quoted(text, key):
    """Extract single-line quoted value for a given key."""
    m = re.search(r'^\s*' + re.escape(key) + r'\s*:\s*"([^"]*)"', text, re.MULTILINE)
    return m.group(1) if m else None


def extract_cmd(item_text):
    """
    Extract the cmd field value from a custom_item block.
    The cmd field may span multiple lines and contains escaped double quotes.
    Pattern: cmd : "...content..." where content may have \\\" but not bare "
    """
    m = re.search(r'^\s*cmd\s*:\s*"((?:[^"\\]|\\.)*)"', item_text, re.DOTALL | re.MULTILINE)
    if not m:
        return None
    return unescape(m.group(1))


def parse_audit(path):
    """Return list of dicts: {cis_id, description, cmd, expect}"""
    with open(path, 'r', encoding='utf-8', errors='replace') as fh:
        content = fh.read()

    checks = []
    for item_text in re.findall(r'<custom_item>(.*?)</custom_item>', content, re.DOTALL):
        # Only CMD_EXEC items
        if not re.search(r'type\s*:\s*CMD_EXEC', item_text):
            continue

        description = extract_quoted(item_text, 'description')
        if not description:
            continue

        # Skip the OS detection check
        if 'Red Hat Enterprise Linux' in description and 'Ensure' not in description:
            continue

        # Parse CIS ID from start of description (e.g. "1.1.1.8 Ensure ...")
        id_match = re.match(r'^(\d[\d.]*)\s', description)
        cis_id = id_match.group(1) if id_match else 'N/A'

        cmd = extract_cmd(item_text)
        if not cmd:
            continue

        expect_raw = extract_quoted(item_text, 'expect')
        expect_re = re.compile(expect_raw, re.MULTILINE | re.IGNORECASE) if expect_raw else EXPECT_PASS_RE

        checks.append({
            'cis_id': cis_id,
            'description': description,
            'cmd': cmd,
            'expect_re': expect_re,
        })

    return checks


def run_cmd(cmd):
    """Run a bash command and return (rc, combined_output)."""
    try:
        proc = subprocess.run(
            cmd,
            shell=True,
            executable='/bin/bash',
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            timeout=CMD_TIMEOUT,
        )
        return proc.returncode, proc.stdout.decode('utf-8', errors='replace').strip()
    except subprocess.TimeoutExpired:
        return -1, 'TIMEOUT after {}s'.format(CMD_TIMEOUT)
    except Exception as exc:
        return -1, 'ERROR: {}'.format(exc)


def main():
    if len(sys.argv) < 3:
        print('Usage: {} <audit_file> <output_csv>'.format(sys.argv[0]))
        sys.exit(1)

    audit_file = sys.argv[1]
    output_csv = sys.argv[2]
    hostname = socket.getfqdn()

    print('Parsing audit file: {}'.format(audit_file))
    checks = parse_audit(audit_file)
    print('Found {} CMD_EXEC checks'.format(len(checks)))

    passed = failed = 0

    with open(output_csv, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        writer.writerow(['hostname', 'cis_id', 'description', 'result', 'output'])

        for check in checks:
            rc, output = run_cmd(check['cmd'])
            result = 'PASS' if check['expect_re'].search(output) else 'FAIL'

            if result == 'PASS':
                passed += 1
            else:
                failed += 1

            # Flatten output for CSV — keep first 800 chars
            output_flat = output[:800].replace('\n', ' | ')

            writer.writerow([
                hostname,
                check['cis_id'],
                check['description'],
                result,
                output_flat,
            ])

            print('[{}] {} {}'.format(result, check['cis_id'], check['description']))

    print('')
    print('Results  : {} PASS  {} FAIL  {} total'.format(passed, failed, passed + failed))
    print('CSV file : {}'.format(output_csv))


if __name__ == '__main__':
    main()
