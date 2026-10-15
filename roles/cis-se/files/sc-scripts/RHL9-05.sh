#!/bin/bash
# RHL9-05 | Ensure nodev option set on /tmp partition

{
   l_output="" l_output2=""

   l_result_1="$(findmnt -kn /tmp | grep -v nodev 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - findmnt -kn /tmp | grep -v nodev: no output (PASS)"
   else
      l_output2="$l_output2\n - findmnt -kn /tmp | grep -v nodev: ${l_result_1}"
   fi

   l_result_2="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
