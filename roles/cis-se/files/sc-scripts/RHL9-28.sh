#!/bin/bash
# RHL9-28 | Ensure AIDE is installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q aide 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q aide: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q aide: ${l_result_1}"
   fi

   l_result_2="$(aide-<version> 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - aide-<version>: no output (PASS)"
   else
      l_output2="$l_output2\n - aide-<version>: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
