#!/bin/bash
# 5.1.15 Ensure SSH ClientAliveCountMax is set to 3 or less

{
   l_output="" l_output2=""
   l_val="$(sshd -T 2>/dev/null | grep -i "^clientalivecountmax" | awk '{print $2}')"
   if [ -n "$l_val" ] && [ "$l_val" -le 3 ] 2>/dev/null; then
      l_output="$l_output\n - ClientAliveCountMax is set to $l_val (acceptable: <= 3)"
   else
      l_output2="$l_output2\n - ClientAliveCountMax is set to '${l_val:-not set}' (expected <= 3)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
