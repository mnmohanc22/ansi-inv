#!/bin/bash
# RHL9-41 | Ensure SETroubleshoot is not installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q setroubleshoot 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q setroubleshoot: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q setroubleshoot: ${l_result_1}"
   fi

   l_result_2="$(package setroubleshoot is not installed 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - package setroubleshoot is not installed: no output (PASS)"
   else
      l_output2="$l_output2\n - package setroubleshoot is not installed: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
