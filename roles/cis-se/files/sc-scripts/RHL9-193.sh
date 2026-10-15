#!/bin/bash
# RHL9-193 | Ensure root path integrity

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output2="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="": ${l_result_2}"
   fi

   l_result_3="$(l_pmask="0022" 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - l_pmask="0022": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pmask="0022": ${l_result_3}"
   fi

   l_result_4="$(l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )": no output (PASS)"
   else
      l_output2="$l_output2\n - l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )": ${l_result_4}"
   fi

   l_result_5="$(l_root_path="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)" 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - l_root_path="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_root_path="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)": ${l_result_5}"
   fi

   l_result_6="$(unset a_path_loc && IFS=":" read -ra a_path_loc <<< "$l_root_path" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - unset a_path_loc && IFS=":" read -ra a_path_loc <<< "$l_root_path": no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_path_loc && IFS=":" read -ra a_path_loc <<< "$l_root_path": ${l_result_6}"
   fi

   l_result_7="$(grep -q "::" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a empty directory (::)" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - grep -q "::" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a empty directory (::)": no output (PASS)"
   else
      l_output2="$l_output2\n - grep -q "::" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a empty directory (::)": ${l_result_7}"
   fi

   l_result_8="$(grep -Pq ":\h*$" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a trailing (:)" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - grep -Pq ":\h*$" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a trailing (:)": no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pq ":\h*$" <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains a trailing (:)": ${l_result_8}"
   fi

   l_result_9="$(grep -Pq '(\h+|:)\.(:|\h*$)' <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains current working directory (.)" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - grep -Pq '(\h+|:)\.(:|\h*$)' <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains current working directory (.)": no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pq '(\h+|:)\.(:|\h*$)' <<< "$l_root_path" && l_output2="$l_output2\n - root's path contains current working directory (.)": ${l_result_9}"
   fi

   l_result_10="$(while read -r l_path; do 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - while read -r l_path; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_path; do: ${l_result_10}"
   fi

   l_result_11="$(if [ -d "$l_path" ]; then 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - if [ -d "$l_path" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_path" ]; then: ${l_result_11}"
   fi

   l_result_12="$(while read -r l_fmode l_fown; do 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - while read -r l_fmode l_fown; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_fmode l_fown; do: ${l_result_12}"
   fi

   l_result_13="$([ "$l_fown" != "root" ] && l_output2="$l_output2\n - Directory: \"$l_path\" is owned by: \"$l_fown\" should be owned by \"root\"" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - [ "$l_fown" != "root" ] && l_output2="$l_output2\n - Directory: \"$l_path\" is owned by: \"$l_fown\" should be owned by \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_fown" != "root" ] && l_output2="$l_output2\n - Directory: \"$l_path\" is owned by: \"$l_fown\" should be owned by \"root\"": ${l_result_13}"
   fi

   l_result_14="$([ $(( $l_fmode & $l_pmask )) -gt 0 ] && l_output2="$l_output2\n - Directory: \"$l_path\" is mode: \"$l_fmode\" and should be mode: \"$l_maxperm\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - [ $(( $l_fmode & $l_pmask )) -gt 0 ] && l_output2="$l_output2\n - Directory: \"$l_path\" is mode: \"$l_fmode\" and should be mode: \"$l_maxperm\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - [ $(( $l_fmode & $l_pmask )) -gt 0 ] && l_output2="$l_output2\n - Directory: \"$l_path\" is mode: \"$l_fmode\" and should be mode: \"$l_maxperm\" or more restrictive": ${l_result_14}"
   fi

   l_result_15="$(done <<< "$(stat -Lc '%#a %U' "$l_path")" 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - done <<< "$(stat -Lc '%#a %U' "$l_path")": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(stat -Lc '%#a %U' "$l_path")": ${l_result_15}"
   fi

   l_result_16="$(else 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_16}"
   fi

   l_result_17="$(l_output2="$l_output2\n - \"$l_path\" is not a directory" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"$l_path\" is not a directory": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"$l_path\" is not a directory": ${l_result_17}"
   fi

   l_result_18="$(done <<< "$(printf "%s\n" "${a_path_loc[@]}")" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - done <<< "$(printf "%s\n" "${a_path_loc[@]}")": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(printf "%s\n" "${a_path_loc[@]}")": ${l_result_18}"
   fi

   l_result_19="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_19}"
   fi

   l_result_20="$(echo -e "\n- Audit Result:\n *** PASS ***\n - Root's path is correctly configured\n" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n *** PASS ***\n - Root's path is correctly configured\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n *** PASS ***\n - Root's path is correctly configured\n": ${l_result_20}"
   fi

   l_result_21="$(else 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_21}"
   fi

   l_result_22="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n": ${l_result_22}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
