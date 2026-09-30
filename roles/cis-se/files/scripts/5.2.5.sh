#!/bin/bash
# 5.2.5 Ensure sudo use_pty is configured

{
   l_output="" l_output2=""
   l_pty="$(grep -rh "^Defaults.*use_pty" /etc/sudoers /etc/sudoers.d/ 2>/dev/null)"
   if [ -n "$l_pty" ]; then
      l_output="$l_output\n - use_pty is configured in sudoers: $l_pty"
   else
      l_output2="$l_output2\n - use_pty is not configured in sudoers"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
