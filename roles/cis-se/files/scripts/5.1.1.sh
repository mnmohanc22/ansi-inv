#!/bin/bash
# 5.1.1 Ensure sshd is enabled

{
   l_output="" l_output2=""
   l_state="$(systemctl is-enabled sshd 2>/dev/null)"
   if [ "$l_state" = "enabled" ]; then
      l_output="$l_output\n - sshd.service is enabled"
   else
      l_output2="$l_output2\n - sshd.service is not enabled (state: ${l_state:-not found})"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
