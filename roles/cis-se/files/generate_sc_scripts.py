#!/usr/bin/env python3
"""Generate RHEL9 SCSEM audit shell scripts from the XLSX test cases sheet."""

import re
import os
import openpyxl

XLSX = "/Users/madineni/workspace/repos/github/ansi-inv/roles/cis-se/files/Safeguards-SCSEM Red Hat Enterprise Linux (RHEL)-v7_02182025.xlsx"
OUT_DIR = "/Users/madineni/workspace/repos/github/ansi-inv/roles/cis-se/files/sc-scripts"

PASS_FAIL_WRAPPER = """\
#!/bin/bash
# {test_id} | {title}

{{
   l_output="" l_output2=""

{check_body}

   if [ -z "$l_output2" ]; then
      echo -e "\\n- Audit Result:\\n  ** PASS **\\n$l_output\\n"
   else
      echo -e "\\n- Audit Result:\\n  ** FAIL **\\n - Reason(s) for audit failure:\\n$l_output2\\n"
      [ -n "$l_output" ] && echo -e "\\n- Correctly set:\\n$l_output\\n"
   fi
}}
"""

MANUAL_TEMPLATE = """\
#!/bin/bash
# {test_id} | {title}
# Test Method: Manual

{{
   echo -e "\\n- Audit Result:\\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\\n- Test Procedure:"
{procedure_lines}
   echo ""
}}
"""

EMBEDDED_SCRIPT_TEMPLATE = """\
#!/bin/bash
# {test_id} | {title}

{script_body}
"""


def extract_code_blocks(text):
    """Extract content from markdown code blocks."""
    blocks = re.findall(r'```(?:bash|shell)?\s*\n(.*?)```', text, re.DOTALL)
    if not blocks:
        # Try inline code or plain command lines
        blocks = re.findall(r'`([^`\n]+)`', text)
    return [b.strip() for b in blocks if b.strip()]


def has_full_pass_fail_script(text):
    """Check if the procedure already contains a full PASS/FAIL bash script."""
    return bool(re.search(r'\*\*\s*PASS\s*\*\*|\bPASS\b', text) and
                re.search(r'\*\*\s*FAIL\s*\*\*|\bFAIL\b', text) and
                'a_output' in text)


def extract_embedded_script(text):
    """Extract a full embedded bash script from the procedure text."""
    # Look for scripts inside code blocks
    blocks = re.findall(r'```(?:bash|shell)?\s*\n(.*?)```', text, re.DOTALL)
    for block in blocks:
        if ('PASS' in block or 'a_output' in block) and '{' in block:
            return block.strip()
    return None


def build_simple_check(commands, title):
    """Build check body for simple grep/findmnt/sysctl type checks."""
    lines = []
    for i, cmd in enumerate(commands):
        cmd = cmd.strip()
        if not cmd or cmd.startswith('#'):
            continue
        # Remove leading # prompt
        cmd = re.sub(r'^#\s*', '', cmd)
        var = f"l_result_{i+1}"
        lines.append(f'   {var}="$({cmd} 2>/dev/null)"')
        lines.append(f'   if [ -z "${{{var}}}" ]; then')
        lines.append(f'      l_output="$l_output\\n - {cmd}: no output (PASS)"')
        lines.append(f'   else')
        lines.append(f'      l_output2="$l_output2\\n - {cmd}: ${{l_result_{i+1}}}"')
        lines.append(f'   fi')
        lines.append('')
    return '\n'.join(lines)


def format_procedure_lines(procedure):
    """Format procedure text as echo lines for manual scripts."""
    lines = []
    for line in procedure.splitlines()[:30]:  # cap at 30 lines
        escaped = line.replace('"', '\\"').replace('$', '\\$').replace('`', '\\`')
        lines.append(f'   echo -e "  {escaped}"')
    return '\n'.join(lines)


def generate_script(test_id, title, method, procedure):
    """Generate shell script content for a test case."""
    if not procedure:
        procedure = "No test procedure provided."

    # Manual test — stub with procedure text
    if 'Manual' in method:
        proc_lines = format_procedure_lines(procedure)
        return MANUAL_TEMPLATE.format(
            test_id=test_id,
            title=title,
            procedure_lines=proc_lines,
        )

    # Automated — check for embedded full PASS/FAIL script
    embedded = extract_embedded_script(procedure)
    if embedded and has_full_pass_fail_script(procedure):
        return EMBEDDED_SCRIPT_TEMPLATE.format(
            test_id=test_id,
            title=title,
            script_body=embedded,
        )

    # Automated — extract individual commands and wrap
    code_blocks = extract_code_blocks(procedure)
    # Filter to commands most likely to be the check (first block usually)
    check_cmds = []
    for block in code_blocks[:2]:
        for line in block.splitlines():
            line = re.sub(r'^#\s*', '', line.strip())
            if line and not line.lower().startswith('example') and len(line) > 3:
                check_cmds.append(line)

    if check_cmds:
        check_body = build_simple_check(check_cmds, title)
    else:
        # Fallback — no extractable command
        check_body = (
            '   # TODO: manual command extraction required\n'
            '   l_output2="$l_output2\\n - Unable to auto-extract check command"'
        )

    return PASS_FAIL_WRAPPER.format(
        test_id=test_id,
        title=title,
        check_body=check_body,
    )


def main():
    wb = openpyxl.load_workbook(XLSX)
    ws = wb['RHEL 9 Test Cases']

    os.makedirs(OUT_DIR, exist_ok=True)

    created = 0
    for r in range(3, ws.max_row + 1):
        test_id = ws.cell(r, 1).value
        if not test_id or not str(test_id).startswith('RHL9'):
            continue

        method    = ws.cell(r, 4).value or ''
        title     = ws.cell(r, 5).value or ''
        procedure = ws.cell(r, 7).value or ''

        content = generate_script(str(test_id), str(title), str(method), str(procedure))

        script_path = os.path.join(OUT_DIR, f"{test_id}.sh")
        with open(script_path, 'w') as f:
            f.write(content)
        os.chmod(script_path, 0o755)
        created += 1

    print(f"Created {created} scripts in {OUT_DIR}")


if __name__ == '__main__':
    main()
