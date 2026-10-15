#!/bin/bash
# RHL9-164 | Ensure root is the only GID 0 account

{
   l_output="" l_output2=""

   l_result_1="$(awk -F: '($1 !~ /^(sync|shutdown|halt|operator)/ && $4=="0") {print $1":"$4}' /etc/passwd 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - awk -F: '($1 !~ /^(sync|shutdown|halt|operator)/ && $4=="0") {print $1":"$4}' /etc/passwd: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F: '($1 !~ /^(sync|shutdown|halt|operator)/ && $4=="0") {print $1":"$4}' /etc/passwd: ${l_result_1}"
   fi

   l_result_2="$(root:0 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - root:0: no output (PASS)"
   else
      l_output2="$l_output2\n - root:0: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
