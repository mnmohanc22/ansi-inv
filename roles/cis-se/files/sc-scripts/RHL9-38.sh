#!/bin/bash
# RHL9-38 | Ensure SELinux policy is configured

{
   l_output="" l_output2=""

   l_result_1="$(grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config: ${l_result_1}"
   fi

   l_result_2="$(SELINUXTYPE=targeted 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - SELINUXTYPE=targeted: no output (PASS)"
   else
      l_output2="$l_output2\n - SELINUXTYPE=targeted: ${l_result_2}"
   fi

   l_result_3="$(sestatus | grep Loaded 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - sestatus | grep Loaded: no output (PASS)"
   else
      l_output2="$l_output2\n - sestatus | grep Loaded: ${l_result_3}"
   fi

   l_result_4="$(Loaded policy name: targeted 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Loaded policy name: targeted: no output (PASS)"
   else
      l_output2="$l_output2\n - Loaded policy name: targeted: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
