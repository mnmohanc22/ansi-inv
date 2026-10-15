#!/bin/bash
# RHL9-39 | Ensure the SELinux mode is not disabled

{
   l_output="" l_output2=""

   l_result_1="$(getenforce 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - getenforce: no output (PASS)"
   else
      l_output2="$l_output2\n - getenforce: ${l_result_1}"
   fi

   l_result_2="$(Enforcing 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Enforcing: no output (PASS)"
   else
      l_output2="$l_output2\n - Enforcing: ${l_result_2}"
   fi

   l_result_3="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_3}"
   fi

   l_result_4="$(Permissive 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Permissive: no output (PASS)"
   else
      l_output2="$l_output2\n - Permissive: ${l_result_4}"
   fi

   l_result_5="$(grep -Ei '^\s*SELINUX=(enforcing|permissive)' /etc/selinux/config 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - grep -Ei '^\s*SELINUX=(enforcing|permissive)' /etc/selinux/config: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Ei '^\s*SELINUX=(enforcing|permissive)' /etc/selinux/config: ${l_result_5}"
   fi

   l_result_6="$(SELINUX=enforcing 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - SELINUX=enforcing: no output (PASS)"
   else
      l_output2="$l_output2\n - SELINUX=enforcing: ${l_result_6}"
   fi

   l_result_7="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_7}"
   fi

   l_result_8="$(SELINUX=permissive 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - SELINUX=permissive: no output (PASS)"
   else
      l_output2="$l_output2\n - SELINUX=permissive: ${l_result_8}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
