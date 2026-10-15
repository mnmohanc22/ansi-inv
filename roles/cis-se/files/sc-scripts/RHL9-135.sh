#!/bin/bash
# RHL9-135 | Ensure sshd access is configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -Pi -- '^\h*(allow|deny)(users|groups)\h+\H+' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -Pi -- '^\h*(allow|deny)(users|groups)\h+\H+': no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -Pi -- '^\h*(allow|deny)(users|groups)\h+\H+': ${l_result_1}"
   fi

   l_result_2="$(allowusers <userlist> 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - allowusers <userlist>: no output (PASS)"
   else
      l_output2="$l_output2\n - allowusers <userlist>: ${l_result_2}"
   fi

   l_result_3="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_3}"
   fi

   l_result_4="$(allowgroups <grouplist> 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - allowgroups <grouplist>: no output (PASS)"
   else
      l_output2="$l_output2\n - allowgroups <grouplist>: ${l_result_4}"
   fi

   l_result_5="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_5}"
   fi

   l_result_6="$(denyusers <userlist> 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - denyusers <userlist>: no output (PASS)"
   else
      l_output2="$l_output2\n - denyusers <userlist>: ${l_result_6}"
   fi

   l_result_7="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_7}"
   fi

   l_result_8="$(denygroups <grouplist> 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - denygroups <grouplist>: no output (PASS)"
   else
      l_output2="$l_output2\n - denygroups <grouplist>: ${l_result_8}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
