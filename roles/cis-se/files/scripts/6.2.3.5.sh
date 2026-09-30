#!/bin/bash
# 6.2.3.5 Ensure journald SystemKeepFree is configured

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*SystemKeepFree\s*=" /etc/systemd/journald.conf 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_output="$l_output\n - SystemKeepFree is configured in /etc/systemd/journald.conf: $l_line"
   else
      l_output2="$l_output2\n - SystemKeepFree is not configured in /etc/systemd/journald.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
