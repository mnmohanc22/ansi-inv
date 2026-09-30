#!/bin/bash
# 5.3.1.3 Ensure authselect includes with-faillock

{
   l_output="" l_output2=""
   l_faillock="$(authselect current 2>/dev/null | grep "with-faillock")"
   if [ -n "$l_faillock" ]; then
      l_output="$l_output\n - authselect has with-faillock configured: $l_faillock"
   else
      l_output2="$l_output2\n - authselect does not have with-faillock configured"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
