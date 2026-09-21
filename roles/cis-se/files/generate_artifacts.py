#!/usr/bin/env python3
"""
One-time generator: parse rhel9.audit and produce:
  - roles/cis-se/files/scripts/NNN_CIS_ID.sh  (one per CMD_EXEC check)
  - roles/cis-se/vars/cis_audit_checks.yml     (check list for Ansible)

Run from the role root:
    python3 files/generate_artifacts.py
"""

import os
import re
import sys


AUDIT_FILE = os.path.join(os.path.dirname(__file__), '..', 'rhel9.audit')
SCRIPTS_DIR = os.path.join(os.path.dirname(__file__), 'scripts')
VARS_FILE = os.path.join(os.path.dirname(__file__), '..', 'vars', 'cis_audit_checks.yml')


def unescape(s):
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
    return unescape(m.group(1)) if m else None


def safe_id(s):
    return re.sub(r'[^a-zA-Z0-9._-]', '_', s)


def yaml_str(s):
    return s.replace("'", "''")


def main():
    os.makedirs(SCRIPTS_DIR, exist_ok=True)
    os.makedirs(os.path.dirname(VARS_FILE), exist_ok=True)

    with open(AUDIT_FILE, 'r', encoding='utf-8', errors='replace') as fh:
        content = fh.read()

    checks = []
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
        script_path = os.path.join(SCRIPTS_DIR, script_name)

        with open(script_path, 'w', encoding='utf-8') as sf:
            sf.write(cmd)
        os.chmod(script_path, 0o755)

        checks.append({
            'index': index,
            'cis_id': cis_id,
            'description': description,
            'script': script_name,
            'expect': expect,
        })

        index += 1

    # Write vars file
    with open(VARS_FILE, 'w', encoding='utf-8') as vf:
        vf.write('# Generated from rhel9.audit — do not edit manually\n')
        vf.write('# Run files/generate_artifacts.py to regenerate\n\n')
        vf.write('cis_audit_checks:\n')
        for c in checks:
            vf.write("  - index: {}\n".format(c['index']))
            vf.write("    cis_id: '{}'\n".format(yaml_str(c['cis_id'])))
            vf.write("    description: '{}'\n".format(yaml_str(c['description'])))
            vf.write("    script: '{}'\n".format(c['script']))
            vf.write("    expect: '{}'\n".format(yaml_str(c['expect'])))

    print('Scripts  : {} files -> {}'.format(len(checks), SCRIPTS_DIR))
    print('Vars     : {}'.format(VARS_FILE))
    print('Done.')


if __name__ == '__main__':
    main()
