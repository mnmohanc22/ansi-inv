#!/bin/bash
# RHL9-157 | Ensure pam_faillock module is enabled

{
   l_output="" l_output2=""

   l_result_1="$(grep -P -- '\bpam_faillock.so\b' /etc/pam.d/{password,system}-auth 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -P -- '\bpam_faillock.so\b' /etc/pam.d/{password,system}-auth: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -P -- '\bpam_faillock.so\b' /etc/pam.d/{password,system}-auth: ${l_result_1}"
   fi

   l_result_2="$(/etc/pam.d/password-auth:auth required pam_faillock.so preauth silent 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:auth required pam_faillock.so preauth silent: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:auth required pam_faillock.so preauth silent: ${l_result_2}"
   fi

   l_result_3="$(/etc/pam.d/password-auth:auth required pam_faillock.so authfail 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:auth required pam_faillock.so authfail: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:auth required pam_faillock.so authfail: ${l_result_3}"
   fi

   l_result_4="$(/etc/pam.d/password-auth:account required pam_faillock.so 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:account required pam_faillock.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:account required pam_faillock.so: ${l_result_4}"
   fi

   l_result_5="$(/etc/pam.d/system-auth:auth required pam_faillock.so preauth silent 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:auth required pam_faillock.so preauth silent: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:auth required pam_faillock.so preauth silent: ${l_result_5}"
   fi

   l_result_6="$(/etc/pam.d/system-auth:auth required pam_faillock.so authfail 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:auth required pam_faillock.so authfail: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:auth required pam_faillock.so authfail: ${l_result_6}"
   fi

   l_result_7="$(/etc/pam.d/system-auth:account required pam_faillock.so 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:account required pam_faillock.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:account required pam_faillock.so: ${l_result_7}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
