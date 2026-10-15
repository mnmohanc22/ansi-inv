#!/bin/bash
# RHL9-171 | Ensure all users last password change date is in the past

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(while IFS= read -r l_user; do 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - while IFS= read -r l_user; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r l_user; do: ${l_result_2}"
   fi

   l_result_3="$(l_change=$(date -d "$(chage --list $l_user | grep '^Last password change' | cut -d: -f2 | grep -v 'never$')" +%s) 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - l_change=$(date -d "$(chage --list $l_user | grep '^Last password change' | cut -d: -f2 | grep -v 'never$')" +%s): no output (PASS)"
   else
      l_output2="$l_output2\n - l_change=$(date -d "$(chage --list $l_user | grep '^Last password change' | cut -d: -f2 | grep -v 'never$')" +%s): ${l_result_3}"
   fi

   l_result_4="$(if [[ "$l_change" -gt "$(date +%s)" ]]; then 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - if [[ "$l_change" -gt "$(date +%s)" ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ "$l_change" -gt "$(date +%s)" ]]; then: ${l_result_4}"
   fi

   l_result_5="$(echo "User: \"$l_user\" last password change was \"$(chage --list $l_user | grep '^Last password change' | cut -d: -f2)\"" 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - echo "User: \"$l_user\" last password change was \"$(chage --list $l_user | grep '^Last password change' | cut -d: -f2)\"": no output (PASS)"
   else
      l_output2="$l_output2\n - echo "User: \"$l_user\" last password change was \"$(chage --list $l_user | grep '^Last password change' | cut -d: -f2)\"": ${l_result_5}"
   fi

   l_result_6="$(done < <(awk -F: '$2~/^\$.+\$/{print $1}' /etc/shadow) 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - done < <(awk -F: '$2~/^\$.+\$/{print $1}' /etc/shadow): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(awk -F: '$2~/^\$.+\$/{print $1}' /etc/shadow): ${l_result_6}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
