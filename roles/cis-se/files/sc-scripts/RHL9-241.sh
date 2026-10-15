#!/bin/bash
# RHL9-241 | Ensure pam_unix does not include nullok

{
   l_output="" l_output2=""

   l_result_1="$(grep -P -- '^\h*(auth|account|password|session)\h+(requisite|required|sufficient)\h+pam_unix\.so\b' /etc/pam.d/{password,system}-auth 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -P -- '^\h*(auth|account|password|session)\h+(requisite|required|sufficient)\h+pam_unix\.so\b' /etc/pam.d/{password,system}-auth: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -P -- '^\h*(auth|account|password|session)\h+(requisite|required|sufficient)\h+pam_unix\.so\b' /etc/pam.d/{password,system}-auth: ${l_result_1}"
   fi

   l_result_2="$(/etc/pam.d/password-auth:auth sufficient pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:auth sufficient pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:auth sufficient pam_unix.so: ${l_result_2}"
   fi

   l_result_3="$(/etc/pam.d/password-auth:account required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:account required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:account required pam_unix.so: ${l_result_3}"
   fi

   l_result_4="$(/etc/pam.d/password-auth:password sufficient pam_unix.so sha512 shadow use_authtok 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:password sufficient pam_unix.so sha512 shadow use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:password sufficient pam_unix.so sha512 shadow use_authtok: ${l_result_4}"
   fi

   l_result_5="$(/etc/pam.d/password-auth:session required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - /etc/pam.d/password-auth:session required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/password-auth:session required pam_unix.so: ${l_result_5}"
   fi

   l_result_6="$(/etc/pam.d/system-auth:auth sufficient pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:auth sufficient pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:auth sufficient pam_unix.so: ${l_result_6}"
   fi

   l_result_7="$(/etc/pam.d/system-auth:account required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:account required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:account required pam_unix.so: ${l_result_7}"
   fi

   l_result_8="$(/etc/pam.d/system-auth:password sufficient pam_unix.so sha512 shadow use_authtok 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:password sufficient pam_unix.so sha512 shadow use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:password sufficient pam_unix.so sha512 shadow use_authtok: ${l_result_8}"
   fi

   l_result_9="$(/etc/pam.d/system-auth:session required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - /etc/pam.d/system-auth:session required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/pam.d/system-auth:session required pam_unix.so: ${l_result_9}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
