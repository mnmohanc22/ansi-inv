#!/bin/bash
# RHL9-229 | Ensure pam_pwquality module is enabled

{
   l_output="" l_output2=""

   l_result_1="$(grep -P -- '\bpam_pwquality\.so\b' /etc/pam.d/{password,system}-auth 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -P -- '\bpam_pwquality\.so\b' /etc/pam.d/{password,system}-auth: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -P -- '\bpam_pwquality\.so\b' /etc/pam.d/{password,system}-auth: ${l_result_1}"
   fi

   l_result_2="$(/etc/pam.d/password-auth:password requisite pam_pwquality.so local_users_only 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:password requisite pam_pwquality.so local_users_only: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:password requisite pam_pwquality.so local_users_only: ${l_result_2}"
   fi

   l_result_3="$(/etc/pam.d/system-auth:password requisite pam_pwquality.so local_users_only 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:password requisite pam_pwquality.so local_users_only: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:password requisite pam_pwquality.so local_users_only: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
