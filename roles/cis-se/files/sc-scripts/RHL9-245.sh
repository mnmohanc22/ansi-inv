#!/bin/bash
# RHL9-245 | Ensure strong password hashing algorithm is configured

{
   l_output="" l_output2=""

   l_result_1="$(grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512)\b' /etc/login.defs 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512)\b' /etc/login.defs: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512)\b' /etc/login.defs: ${l_result_1}"
   fi

   l_result_2="$(ENCRYPT_METHOD SHA512 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - ENCRYPT_METHOD SHA512: no output (PASS)"
   else
      l_output2="$l_output2\n - ENCRYPT_METHOD SHA512: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
