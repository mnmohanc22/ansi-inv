#!/bin/bash
# RHL9-154 | Ensure sudo authentication timeout is configured correctly

{
   l_output="" l_output2=""

   l_result_1="$(grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers*: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers*: ${l_result_1}"
   fi

   l_result_2="$(sudo -V | grep "Authentication timestamp timeout:" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - sudo -V | grep "Authentication timestamp timeout:": no output (PASS)"
   else
      l_output2="$l_output2\n - sudo -V | grep "Authentication timestamp timeout:": ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
