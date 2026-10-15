#!/bin/bash
# RHL9-187 | Ensure /etc/shadow password fields are not empty

{
   l_output="" l_output2=""

   l_result_1="$(awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow: ${l_result_1}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
