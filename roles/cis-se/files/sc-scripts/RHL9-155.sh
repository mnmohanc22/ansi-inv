#!/bin/bash
# RHL9-155 | Ensure access to the su command is restricted

{
   l_output="" l_output2=""

   l_result_1="$(grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su: ${l_result_1}"
   fi

   l_result_2="$(auth required pam_wheel.so use_uid group=<group_name> 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - auth required pam_wheel.so use_uid group=<group_name>: no output (PASS)"
   else
      l_output2="$l_output2\n - auth required pam_wheel.so use_uid group=<group_name>: ${l_result_2}"
   fi

   l_result_3="$(grep <group_name> /etc/group 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - grep <group_name> /etc/group: no output (PASS)"
   else
      l_output2="$l_output2\n - grep <group_name> /etc/group: ${l_result_3}"
   fi

   l_result_4="$(<group_name>:x:<GID>: 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - <group_name>:x:<GID>:: no output (PASS)"
   else
      l_output2="$l_output2\n - <group_name>:x:<GID>:: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
