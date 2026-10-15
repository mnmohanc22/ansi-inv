#!/bin/bash
# RHL9-242 | Ensure pam_unix does not include remember

{
   l_output="" l_output2=""

   l_result_1="$(grep -Pi '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\b' /etc/pam.d/{password,system}-auth | grep -Pv '\bremember=\d\b' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Pi '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\b' /etc/pam.d/{password,system}-auth | grep -Pv '\bremember=\d\b': no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pi '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\b' /etc/pam.d/{password,system}-auth | grep -Pv '\bremember=\d\b': ${l_result_1}"
   fi

   l_result_2="$(/etc/pam.d/password-auth:password sufficient pam_unix.so sha512 shadow use_authtok 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:password sufficient pam_unix.so sha512 shadow use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:password sufficient pam_unix.so sha512 shadow use_authtok: ${l_result_2}"
   fi

   l_result_3="$(/etc/pam.d/system-auth:password sufficient pam_unix.so sha512 shadow use_authtok 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:password sufficient pam_unix.so sha512 shadow use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:password sufficient pam_unix.so sha512 shadow use_authtok: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
