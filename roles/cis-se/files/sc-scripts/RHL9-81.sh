#!/bin/bash
# RHL9-81 | Ensure ftp client is not installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q ftp 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q ftp: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q ftp: ${l_result_1}"
   fi

   l_result_2="$(package ftp is not installed 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - package ftp is not installed: no output (PASS)"
   else
      l_output2="$l_output2\n - package ftp is not installed: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
