#!/bin/bash
# RHL9-156 | Ensure active authselect profile includes pam modules

{
   l_output="" l_output2=""

   l_result_1="$(grep -P -- '\b(pam_pwquality\.so|pam_pwhistory\.so|pam_faillock\.so|pam_unix\.so)\b' /etc/authselect/"$(head -1 /etc/authselect/authselect.conf)"/{system,password}-auth 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -P -- '\b(pam_pwquality\.so|pam_pwhistory\.so|pam_faillock\.so|pam_unix\.so)\b' /etc/authselect/"$(head -1 /etc/authselect/authselect.conf)"/{system,password}-auth: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -P -- '\b(pam_pwquality\.so|pam_pwhistory\.so|pam_faillock\.so|pam_unix\.so)\b' /etc/authselect/"$(head -1 /etc/authselect/authselect.conf)"/{system,password}-auth: ${l_result_1}"
   fi

   l_result_2="$(/etc/authselect/custom/custom-profile/password-auth:auth required pam_faillock.so preauth silent {include if "with-faillock"} 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:auth required pam_faillock.so preauth silent {include if "with-faillock"}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:auth required pam_faillock.so preauth silent {include if "with-faillock"}: ${l_result_2}"
   fi

   l_result_3="$(/etc/authselect/custom/custom-profile/password-auth:auth sufficient pam_unix.so {if not "without-nullok":nullok} 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:auth sufficient pam_unix.so {if not "without-nullok":nullok}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:auth sufficient pam_unix.so {if not "without-nullok":nullok}: ${l_result_3}"
   fi

   l_result_4="$(/etc/authselect/custom/custom-profile/password-auth:auth required pam_faillock.so authfail {include if "with-faillock"} 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:auth required pam_faillock.so authfail {include if "with-faillock"}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:auth required pam_faillock.so authfail {include if "with-faillock"}: ${l_result_4}"
   fi

   l_result_5="$(/etc/authselect/custom/custom-profile/password-auth:account required pam_faillock.so {include if "with-faillock"} 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:account required pam_faillock.so {include if "with-faillock"}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:account required pam_faillock.so {include if "with-faillock"}: ${l_result_5}"
   fi

   l_result_6="$(/etc/authselect/custom/custom-profile/password-auth:account required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:account required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:account required pam_unix.so: ${l_result_6}"
   fi

   l_result_7="$(/etc/authselect/custom/custom-profile/password-auth:password requisite pam_pwquality.so local_users_only 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:password requisite pam_pwquality.so local_users_only: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:password requisite pam_pwquality.so local_users_only: ${l_result_7}"
   fi

   l_result_8="$(/etc/authselect/custom/custom-profile/password-auth:password required pam_pwhistory.so use_authtok 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:password required pam_pwhistory.so use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:password required pam_pwhistory.so use_authtok: ${l_result_8}"
   fi

   l_result_9="$(/etc/authselect/custom/custom-profile/password-auth:password sufficient pam_unix.so sha512 shadow {if not "without-nullok":nullok} use_authtok 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:password sufficient pam_unix.so sha512 shadow {if not "without-nullok":nullok} use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:password sufficient pam_unix.so sha512 shadow {if not "without-nullok":nullok} use_authtok: ${l_result_9}"
   fi

   l_result_10="$(/etc/authselect/custom/custom-profile/password-auth:session required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/password-auth:session required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/password-auth:session required pam_unix.so: ${l_result_10}"
   fi

   l_result_11="$(/etc/authselect/custom/custom-profile/system-auth:auth required pam_faillock.so preauth silent {include if "with-faillock"} 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:auth required pam_faillock.so preauth silent {include if "with-faillock"}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:auth required pam_faillock.so preauth silent {include if "with-faillock"}: ${l_result_11}"
   fi

   l_result_12="$(/etc/authselect/custom/custom-profile/system-auth:auth sufficient pam_unix.so {if not "without-nullok":nullok} 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:auth sufficient pam_unix.so {if not "without-nullok":nullok}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:auth sufficient pam_unix.so {if not "without-nullok":nullok}: ${l_result_12}"
   fi

   l_result_13="$(/etc/authselect/custom/custom-profile/system-auth:auth required pam_faillock.so authfail {include if "with-faillock"} 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:auth required pam_faillock.so authfail {include if "with-faillock"}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:auth required pam_faillock.so authfail {include if "with-faillock"}: ${l_result_13}"
   fi

   l_result_14="$(/etc/authselect/custom/custom-profile/system-auth:account required pam_faillock.so {include if "with-faillock"} 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:account required pam_faillock.so {include if "with-faillock"}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:account required pam_faillock.so {include if "with-faillock"}: ${l_result_14}"
   fi

   l_result_15="$(/etc/authselect/custom/custom-profile/system-auth:account required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:account required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:account required pam_unix.so: ${l_result_15}"
   fi

   l_result_16="$(/etc/authselect/custom/custom-profile/system-auth:password requisite pam_pwquality.so local_users_only 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:password requisite pam_pwquality.so local_users_only: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:password requisite pam_pwquality.so local_users_only: ${l_result_16}"
   fi

   l_result_17="$(/etc/authselect/custom/custom-profile/system-auth:password required pam_pwhistory.so use_authtok 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:password required pam_pwhistory.so use_authtok: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:password required pam_pwhistory.so use_authtok: ${l_result_17}"
   fi

   l_result_18="$(/etc/authselect/custom/custom-profile/system-auth:password sufficient pam_unix.so sha512 shadow {if not "without-nullok":nullok} 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:password sufficient pam_unix.so sha512 shadow {if not "without-nullok":nullok}: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:password sufficient pam_unix.so sha512 shadow {if not "without-nullok":nullok}: ${l_result_18}"
   fi

   l_result_19="$(/etc/authselect/custom/custom-profile/system-auth:session required pam_unix.so 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - /etc/authselect/custom/custom-profile/system-auth:session required pam_unix.so: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/authselect/custom/custom-profile/system-auth:session required pam_unix.so: ${l_result_19}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
