#!/bin/bash
# RHL9-220 | Ensure chrony is configured

{
   l_output="" l_output2=""

   l_result_1="$(grep -Prs -- '^\h*(server|pool)\h+[^#\n\r]+' /etc/chrony.conf /etc/chrony.d/ 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Prs -- '^\h*(server|pool)\h+[^#\n\r]+' /etc/chrony.conf /etc/chrony.d/: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Prs -- '^\h*(server|pool)\h+[^#\n\r]+' /etc/chrony.conf /etc/chrony.d/: ${l_result_1}"
   fi

   l_result_2="$(server <remote-server> 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - server <remote-server>: no output (PASS)"
   else
      l_output2="$l_output2\n - server <remote-server>: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
