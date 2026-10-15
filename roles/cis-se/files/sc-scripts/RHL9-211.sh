#!/bin/bash
# RHL9-211 | Ensure system wide crypto policy disables sha1 hash and signature support

{
   l_output="" l_output2=""

   l_result_1="$(awk -F= '($1~/(hash|sign)/ && $2~/SHA1/ && $2!~/^\s*\-\s*([^#\n\r]+)?SHA1/){print}' /etc/crypto-policies/state/CURRENT.pol 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - awk -F= '($1~/(hash|sign)/ && $2~/SHA1/ && $2!~/^\s*\-\s*([^#\n\r]+)?SHA1/){print}' /etc/crypto-policies/state/CURRENT.pol: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F= '($1~/(hash|sign)/ && $2~/SHA1/ && $2!~/^\s*\-\s*([^#\n\r]+)?SHA1/){print}' /etc/crypto-policies/state/CURRENT.pol: ${l_result_1}"
   fi

   l_result_2="$(grep -Psi -- '^\h*sha1_in_certs\h*=\h*' /etc/crypto-policies/state/CURRENT.pol 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*sha1_in_certs\h*=\h*' /etc/crypto-policies/state/CURRENT.pol: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*sha1_in_certs\h*=\h*' /etc/crypto-policies/state/CURRENT.pol: ${l_result_2}"
   fi

   l_result_3="$(sha1_in_certs = 0 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - sha1_in_certs = 0: no output (PASS)"
   else
      l_output2="$l_output2\n - sha1_in_certs = 0: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
