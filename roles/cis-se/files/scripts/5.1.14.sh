#!/bin/bash
# 5.1.14 Ensure SSH ClientAliveInterval is between 1 and 900

{
   l_output="" l_output2=""
   l_val="$(sshd -T 2>/dev/null | grep -i "^clientaliveinterval" | awk '{print $2}')"
   if [ -n "$l_val" ] && [ "$l_val" -gt 0 ] && [ "$l_val" -le 900 ] 2>/dev/null; then
      l_output="$l_output\n - ClientAliveInterval is set to $l_val (acceptable: 1-900)"
   else
      l_output2="$l_output2\n - ClientAliveInterval is set to '${l_val:-not set}' (expected 1-900)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
