#!/bin/bash
# RHL9-224 | Ensure sshd KexAlgorithms is configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -Pi -- 'kexalgorithms\h+([^#\n\r]+,)?(diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)\b' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -Pi -- 'kexalgorithms\h+([^#\n\r]+,)?(diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)\b': no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -Pi -- 'kexalgorithms\h+([^#\n\r]+,)?(diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)\b': ${l_result_1}"
   fi

   l_result_2="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_2}"
   fi

   l_result_3="$(diffie-hellman-group1-sha1 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - diffie-hellman-group1-sha1: no output (PASS)"
   else
      l_output2="$l_output2\n - diffie-hellman-group1-sha1: ${l_result_3}"
   fi

   l_result_4="$(diffie-hellman-group14-sha1 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - diffie-hellman-group14-sha1: no output (PASS)"
   else
      l_output2="$l_output2\n - diffie-hellman-group14-sha1: ${l_result_4}"
   fi

   l_result_5="$(diffie-hellman-group-exchange-sha1 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - diffie-hellman-group-exchange-sha1: no output (PASS)"
   else
      l_output2="$l_output2\n - diffie-hellman-group-exchange-sha1: ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
