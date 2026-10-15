#!/bin/bash
# RHL9-227 | Ensure latest version of authselect is installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q authselect 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q authselect: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q authselect: ${l_result_1}"
   fi

   l_result_2="$(authselect-1.2.6-2.el9.x86_64 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - authselect-1.2.6-2.el9.x86_64: no output (PASS)"
   else
      l_output2="$l_output2\n - authselect-1.2.6-2.el9.x86_64: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
