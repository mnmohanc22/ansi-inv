#!/bin/bash
# RHL9-166 | Ensure root account access is controlled

{
   l_output="" l_output2=""

   l_result_1="$(passwd -S root | awk '$2 ~ /^P/ {print "User: \"" $1 "\" Password is set"}' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - passwd -S root | awk '$2 ~ /^P/ {print "User: \"" $1 "\" Password is set"}': no output (PASS)"
   else
      l_output2="$l_output2\n - passwd -S root | awk '$2 ~ /^P/ {print "User: \"" $1 "\" Password is set"}': ${l_result_1}"
   fi

   l_result_2="$((Password set, SHA512 crypt.) 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - (Password set, SHA512 crypt.): no output (PASS)"
   else
      l_output2="$l_output2\n - (Password set, SHA512 crypt.): ${l_result_2}"
   fi

   l_result_3="$(- OR - 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - - OR -: no output (PASS)"
   else
      l_output2="$l_output2\n - - OR -: ${l_result_3}"
   fi

   l_result_4="$((Password locked.) 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - (Password locked.): no output (PASS)"
   else
      l_output2="$l_output2\n - (Password locked.): ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
