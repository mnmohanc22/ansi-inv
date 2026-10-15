#!/bin/bash
# RHL9-216 | Ensure autofs services are not in use

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q autofs 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q autofs: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q autofs: ${l_result_1}"
   fi

   l_result_2="$(package autofs is not installed 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - package autofs is not installed: no output (PASS)"
   else
      l_output2="$l_output2\n - package autofs is not installed: ${l_result_2}"
   fi

   l_result_3="$(systemctl is-enabled autofs.service 2>/dev/null | grep 'enabled' 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - systemctl is-enabled autofs.service 2>/dev/null | grep 'enabled': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-enabled autofs.service 2>/dev/null | grep 'enabled': ${l_result_3}"
   fi

   l_result_4="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
