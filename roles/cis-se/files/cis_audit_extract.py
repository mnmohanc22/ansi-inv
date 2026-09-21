#!/usr/bin/env python3
"""
Parse Tenable .audit file and extract each CMD_EXEC cmd field
to an individual .sh script file.

Also writes a manifest JSON listing every check:
  [{index, cis_id, description, script, expect}]

Usage:
    python3 cis_audit_extract.py <audit_file> <output_dir>

Output:
    <output_dir>/scripts/<index>_<cis_id>.sh  — one per check
    <output_dir>/manifest.json                — check list
"""

import json
import os
import re
import sys


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
    m = re.search(r'^\s*' + re.escape(key) + r'\s*:\s*"([^"]*)"', text, re.MULTILINE)
    return m.group(1) if m else None


def extract_cmd(item_text):
    m = re.search(r'^\s*cmd\s*:\s*"((?:[^"\\]|\\.)*)"', item_text, re.DOTALL | re.MULTILINE)
    if not m:
        return None
    return unescape(m.group(1))


def safe_id(cis_id):
    return re.sub(r'[^a-zA-Z0-9._-]', '_', cis_id)


def parse_and_extract(audit_path, output_dir):
    scripts_dir = os.path.join(output_dir, 'scripts')
    os.makedirs(scripts_dir, exist_ok=True)

    with open(audit_path, 'r', encoding='utf-8', errors='replace') as fh:
        content = fh.read()

    manifest = []
    index = 0

    for item_text in re.findall(r'<custom_item>(.*?)</custom_item>', content, re.DOTALL):
        if not re.search(r'type\s*:\s*CMD_EXEC', item_text):
            continue

        description = extract_quoted(item_text, 'description')
        if not description:
            continue

        cmd = extract_cmd(item_text)
        if not cmd:
            continue

        id_match = re.match(r'^(\d[\d.]*)\s', description)
        cis_id = id_match.group(1) if id_match else 'NA'

        expect = extract_quoted(item_text, 'expect') or r'(?i)^\s*\**\s*pass:?\s*\**\s*$'

        script_name = '{:03d}_{}.sh'.format(index, safe_id(cis_id))
        script_path = os.path.join(scripts_dir, script_name)

        with open(script_path, 'w', encoding='utf-8') as sf:
            sf.write(cmd)

        os.chmod(script_path, 0o750)

        manifest.append({
            'index': index,
            'cis_id': cis_id,
            'description': description,
            'script': script_name,
            'expect': expect,
        })

        index += 1

    manifest_path = os.path.join(output_dir, 'manifest.json')
    with open(manifest_path, 'w', encoding='utf-8') as mf:
        json.dump(manifest, mf, indent=2)

    print('Extracted : {} scripts -> {}'.format(len(manifest), scripts_dir))
    print('Manifest  : {}'.format(manifest_path))
    return len(manifest)


def main():
    if len(sys.argv) < 3:
        print('Usage: {} <audit_file> <output_dir>'.format(sys.argv[0]))
        sys.exit(1)

    count = parse_and_extract(sys.argv[1], sys.argv[2])
    print('Done. {} checks extracted.'.format(count))


if __name__ == '__main__':
    main()
