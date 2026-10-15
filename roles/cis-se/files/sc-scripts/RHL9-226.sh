#!/bin/bash
# RHL9-226 | Ensure latest version of pam is installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q pam 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q pam: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q pam: ${l_result_1}"
   fi

   l_result_2="$(pam-1.5.1-19.el9.x86_64 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - pam-1.5.1-19.el9.x86_64: no output (PASS)"
   else
      l_output2="$l_output2\n - pam-1.5.1-19.el9.x86_64: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
