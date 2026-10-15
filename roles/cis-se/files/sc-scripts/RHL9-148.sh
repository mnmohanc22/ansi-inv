#!/bin/bash
# RHL9-148 | Ensure sshd LoginGraceTime is configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep logingracetime 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep logingracetime: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep logingracetime: ${l_result_1}"
   fi

   l_result_2="$(logingracetime 60 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - logingracetime 60: no output (PASS)"
   else
      l_output2="$l_output2\n - logingracetime 60: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
