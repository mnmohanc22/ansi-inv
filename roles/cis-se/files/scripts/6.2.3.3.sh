#!/bin/bash
# 6.2.3.3 Ensure journald log storage is configured to persistent

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*Storage\s*=\s*persistent" /etc/systemd/journald.conf 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_output="$l_output\n - Storage=persistent is configured in /etc/systemd/journald.conf"
   else
      l_output2="$l_output2\n - Storage=persistent is not configured in /etc/systemd/journald.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
