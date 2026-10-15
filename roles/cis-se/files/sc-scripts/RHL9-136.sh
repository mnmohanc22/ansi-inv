#!/bin/bash
# RHL9-136 | Ensure sshd LogLevel is configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep loglevel 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep loglevel: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep loglevel: ${l_result_1}"
   fi

   l_result_2="$(loglevel VERBOSE 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - loglevel VERBOSE: no output (PASS)"
   else
      l_output2="$l_output2\n - loglevel VERBOSE: ${l_result_2}"
   fi

   l_result_3="$(- OR - 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - - OR -: no output (PASS)"
   else
      l_output2="$l_output2\n - - OR -: ${l_result_3}"
   fi

   l_result_4="$(loglevel INFO 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - loglevel INFO: no output (PASS)"
   else
      l_output2="$l_output2\n - loglevel INFO: ${l_result_4}"
   fi

   l_result_5="$(sshd -T -C user=sshuser | grep loglevel 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - sshd -T -C user=sshuser | grep loglevel: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T -C user=sshuser | grep loglevel: ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
