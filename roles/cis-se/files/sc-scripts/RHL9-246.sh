#!/bin/bash
# RHL9-246 | Ensure root is the only UID 0 account

{
   l_output="" l_output2=""

   l_result_1="$(awk -F: '($3 == 0) { print $1 }' /etc/passwd 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - awk -F: '($3 == 0) { print $1 }' /etc/passwd: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F: '($3 == 0) { print $1 }' /etc/passwd: ${l_result_1}"
   fi

   l_result_2="$(root 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - root: no output (PASS)"
   else
      l_output2="$l_output2\n - root: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
