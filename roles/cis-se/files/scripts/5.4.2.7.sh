#!/bin/bash
# 5.4.2.7 Ensure root PATH does not include empty directories or dot

{
   l_output="" l_output2=""
   l_badpath="$(echo "$PATH" | tr ':' '\n' | grep -E "^\.$|^$")"
   if [ -n "$l_badpath" ]; then
      l_output2="$l_output2\n - root PATH contains empty or dot entries:\n$l_badpath"
   else
      l_output="$l_output\n - root PATH does not contain empty or dot entries"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
