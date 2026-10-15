#!/bin/bash
# RHL9-228 | Ensure latest version of libpwquality is installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q libpwquality 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q libpwquality: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q libpwquality: ${l_result_1}"
   fi

   l_result_2="$(libpwquality-1.4.4-8.el9.x86_64 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - libpwquality-1.4.4-8.el9.x86_64: no output (PASS)"
   else
      l_output2="$l_output2\n - libpwquality-1.4.4-8.el9.x86_64: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
