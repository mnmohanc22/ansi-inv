#!/bin/bash
# 5.1.16 Ensure SSH LoginGraceTime is set to 1-60 seconds

{
   l_output="" l_output2=""
   l_val="$(sshd -T 2>/dev/null | grep -i "^logingraceperiod" | awk '{print $2}')"
   if [ -n "$l_val" ] && [ "$l_val" -gt 0 ] && [ "$l_val" -le 60 ] 2>/dev/null; then
      l_output="$l_output\n - LoginGraceTime is set to $l_val (acceptable: 1-60)"
   else
      l_output2="$l_output2\n - LoginGraceTime is set to '${l_val:-not set}' (expected 1-60)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
