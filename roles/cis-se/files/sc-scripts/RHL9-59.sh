#!/bin/bash
# RHL9-59 | Ensure time synchronization is in use

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q chrony 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q chrony: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q chrony: ${l_result_1}"
   fi

   l_result_2="$(chrony-<version> 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - chrony-<version>: no output (PASS)"
   else
      l_output2="$l_output2\n - chrony-<version>: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
