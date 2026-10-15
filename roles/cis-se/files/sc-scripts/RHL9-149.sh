#!/bin/bash
# RHL9-149 | Ensure sshd ClientAliveInterval and ClientAliveCountMax are configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -Pi -- '(clientaliveinterval|clientalivecountmax)' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -Pi -- '(clientaliveinterval|clientalivecountmax)': no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -Pi -- '(clientaliveinterval|clientalivecountmax)': ${l_result_1}"
   fi

   l_result_2="$(clientaliveinterval 15 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - clientaliveinterval 15: no output (PASS)"
   else
      l_output2="$l_output2\n - clientaliveinterval 15: ${l_result_2}"
   fi

   l_result_3="$(clientalivecountmax 3 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - clientalivecountmax 3: no output (PASS)"
   else
      l_output2="$l_output2\n - clientalivecountmax 3: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
