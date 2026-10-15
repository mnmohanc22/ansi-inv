#!/bin/bash
# RHL9-188 | Ensure all groups in /etc/passwd exist in /etc/group

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(a_passwd_group_gid=("$(awk -F: '{print $4}' /etc/passwd | sort -u)") 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - a_passwd_group_gid=("$(awk -F: '{print $4}' /etc/passwd | sort -u)"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_passwd_group_gid=("$(awk -F: '{print $4}' /etc/passwd | sort -u)"): ${l_result_2}"
   fi

   l_result_3="$(a_group_gid=("$(awk -F: '{print $3}' /etc/group | sort -u)") 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - a_group_gid=("$(awk -F: '{print $3}' /etc/group | sort -u)"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_group_gid=("$(awk -F: '{print $3}' /etc/group | sort -u)"): ${l_result_3}"
   fi

   l_result_4="$(a_passwd_group_diff=("$(printf '%s\n' "${a_group_gid[@]}" "${a_passwd_group_gid[@]}" | sort | uniq -u)") 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - a_passwd_group_diff=("$(printf '%s\n' "${a_group_gid[@]}" "${a_passwd_group_gid[@]}" | sort | uniq -u)"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_passwd_group_diff=("$(printf '%s\n' "${a_group_gid[@]}" "${a_passwd_group_gid[@]}" | sort | uniq -u)"): ${l_result_4}"
   fi

   l_result_5="$(while IFS= read -r l_gid; do 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - while IFS= read -r l_gid; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r l_gid; do: ${l_result_5}"
   fi

   l_result_6="$(awk -F: '($4 == '"$l_gid"') {print " - User: \"" $1 "\" has GID: \"" $4 "\" which does not exist in /etc/group" }' /etc/passwd 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - awk -F: '($4 == '"$l_gid"') {print " - User: \"" $1 "\" has GID: \"" $4 "\" which does not exist in /etc/group" }' /etc/passwd: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F: '($4 == '"$l_gid"') {print " - User: \"" $1 "\" has GID: \"" $4 "\" which does not exist in /etc/group" }' /etc/passwd: ${l_result_6}"
   fi

   l_result_7="$(done < <(printf '%s\n' "${a_passwd_group_gid[@]}" "${a_passwd_group_diff[@]}" | sort | uniq -D | uniq) 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - done < <(printf '%s\n' "${a_passwd_group_gid[@]}" "${a_passwd_group_diff[@]}" | sort | uniq -D | uniq): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(printf '%s\n' "${a_passwd_group_gid[@]}" "${a_passwd_group_diff[@]}" | sort | uniq -D | uniq): ${l_result_7}"
   fi

   l_result_8="$(unset a_passwd_group_gid; unset a_group_gid; unset a_passwd_group_diff 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - unset a_passwd_group_gid; unset a_group_gid; unset a_passwd_group_diff: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_passwd_group_gid; unset a_group_gid; unset a_passwd_group_diff: ${l_result_8}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
