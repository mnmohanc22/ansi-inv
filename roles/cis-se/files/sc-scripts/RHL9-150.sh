#!/bin/bash
# RHL9-150 | Ensure sudo is installed

{
   l_output="" l_output2=""

   l_result_1="$(dnf list sudo 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - dnf list sudo: no output (PASS)"
   else
      l_output2="$l_output2\n - dnf list sudo: ${l_result_1}"
   fi

   l_result_2="$(Installed Packages 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Installed Packages: no output (PASS)"
   else
      l_output2="$l_output2\n - Installed Packages: ${l_result_2}"
   fi

   l_result_3="$(sudo.x86_64 <VERSION> @anaconda 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - sudo.x86_64 <VERSION> @anaconda: no output (PASS)"
   else
      l_output2="$l_output2\n - sudo.x86_64 <VERSION> @anaconda: ${l_result_3}"
   fi

   l_result_4="$(Available Packages 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Available Packages: no output (PASS)"
   else
      l_output2="$l_output2\n - Available Packages: ${l_result_4}"
   fi

   l_result_5="$(sudo.x86_64 <VERSION> updates 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - sudo.x86_64 <VERSION> updates: no output (PASS)"
   else
      l_output2="$l_output2\n - sudo.x86_64 <VERSION> updates: ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
