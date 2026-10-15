#!/bin/bash
# RHL9-26 | Ensure gpgcheck is globally activated

{
   l_output="" l_output2=""

   l_result_1="$(grep -Pi -- '^\h*gpgcheck\h*=\h*(1|true|yes)\b' /etc/dnf/dnf.conf 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Pi -- '^\h*gpgcheck\h*=\h*(1|true|yes)\b' /etc/dnf/dnf.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pi -- '^\h*gpgcheck\h*=\h*(1|true|yes)\b' /etc/dnf/dnf.conf: ${l_result_1}"
   fi

   l_result_2="$(gpgcheck=1 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - gpgcheck=1: no output (PASS)"
   else
      l_output2="$l_output2\n - gpgcheck=1: ${l_result_2}"
   fi

   l_result_3="$(grep -Pris -- '^\h*gpgcheck\h*=\h*(0|[2-9]|[1-9][0-9]+|false|no)\b' /etc/yum.repos.d/ 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - grep -Pris -- '^\h*gpgcheck\h*=\h*(0|[2-9]|[1-9][0-9]+|false|no)\b' /etc/yum.repos.d/: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pris -- '^\h*gpgcheck\h*=\h*(0|[2-9]|[1-9][0-9]+|false|no)\b' /etc/yum.repos.d/: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
