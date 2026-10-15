#!/bin/bash
# RHL9-191 | Ensure no duplicate user names exist

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(while read -r l_count l_user; do 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - while read -r l_count l_user; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_count l_user; do: ${l_result_2}"
   fi

   l_result_3="$(if [ "$l_count" -gt 1 ]; then 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - if [ "$l_count" -gt 1 ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_count" -gt 1 ]; then: ${l_result_3}"
   fi

   l_result_4="$(echo -e "Duplicate User: \"$l_user\" Users: \"$(awk -F: '($1 == n) { print $1 }' n=$l_user /etc/passwd | xargs)\"" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - echo -e "Duplicate User: \"$l_user\" Users: \"$(awk -F: '($1 == n) { print $1 }' n=$l_user /etc/passwd | xargs)\"": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "Duplicate User: \"$l_user\" Users: \"$(awk -F: '($1 == n) { print $1 }' n=$l_user /etc/passwd | xargs)\"": ${l_result_4}"
   fi

   l_result_5="$(done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c) 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c): ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
