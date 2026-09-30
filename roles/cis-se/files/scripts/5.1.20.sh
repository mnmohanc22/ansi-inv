#!/bin/bash
# 5.1.20 Ensure SSH MaxStartups is configured to 10:30:60 or more restrictive

{
   l_output="" l_output2=""
   l_val="$(sshd -T 2>/dev/null | grep -i "^maxstartups" | awk '{print $2}')"
   if [ -n "$l_val" ]; then
      l_start="$(echo "$l_val" | cut -d: -f1)"
      l_rate="$(echo "$l_val" | cut -d: -f2)"
      l_full="$(echo "$l_val" | cut -d: -f3)"
      if [ "$l_start" -le 10 ] && [ "$l_rate" -le 30 ] && [ "$l_full" -le 60 ] 2>/dev/null; then
         l_output="$l_output\n - MaxStartups is set to $l_val (acceptable: 10:30:60 or more restrictive)"
      else
         l_output2="$l_output2\n - MaxStartups is set to $l_val (expected 10:30:60 or more restrictive)"
      fi
   else
      l_output2="$l_output2\n - MaxStartups is not set"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
