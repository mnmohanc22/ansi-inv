#!/bin/bash
# RHL9-170 | Ensure inactive password lock is configured

{
   l_output="" l_output2=""

   l_result_1="$(useradd -D | grep INACTIVE 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - useradd -D | grep INACTIVE: no output (PASS)"
   else
      l_output2="$l_output2\n - useradd -D | grep INACTIVE: ${l_result_1}"
   fi

   l_result_2="$(INACTIVE=120 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - INACTIVE=120: no output (PASS)"
   else
      l_output2="$l_output2\n - INACTIVE=120: ${l_result_2}"
   fi

   l_result_3="$(awk -F: '($2~/^\$.+\$/) {if($7 > 120 || $7 < 0)print "User: " $1 " INACTIVE: " $7}' /etc/shadow 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - awk -F: '($2~/^\$.+\$/) {if($7 > 120 || $7 < 0)print "User: " $1 " INACTIVE: " $7}' /etc/shadow: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F: '($2~/^\$.+\$/) {if($7 > 120 || $7 < 0)print "User: " $1 " INACTIVE: " $7}' /etc/shadow: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
