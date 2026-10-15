#!/bin/bash
# RHL9-195 | Ensure local interactive user home directories are configured

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2="": ${l_result_2}"
   fi

   l_result_3="$(l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$": no output (PASS)"
   else
      l_output2="$l_output2\n - l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$": ${l_result_3}"
   fi

   l_result_4="$(unset a_uarr && a_uarr=() # Clear and initialize array 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - unset a_uarr && a_uarr=() # Clear and initialize array: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_uarr && a_uarr=() # Clear and initialize array: ${l_result_4}"
   fi

   l_result_5="$(while read -r l_epu l_eph; do # Populate array with users and user home location 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - while read -r l_epu l_eph; do # Populate array with users and user home location: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_epu l_eph; do # Populate array with users and user home location: ${l_result_5}"
   fi

   l_result_6="$(a_uarr+=("$l_epu $l_eph") 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - a_uarr+=("$l_epu $l_eph"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_uarr+=("$l_epu $l_eph"): ${l_result_6}"
   fi

   l_result_7="$(done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)": ${l_result_7}"
   fi

   l_result_8="$(l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding: no output (PASS)"
   else
      l_output2="$l_output2\n - l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding: ${l_result_8}"
   fi

   l_result_9="$([ "$l_asize " -gt "10000" ] && echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive users found on the system\n - This may be a long running check\n" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - [ "$l_asize " -gt "10000" ] && echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive users found on the system\n - This may be a long running check\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_asize " -gt "10000" ] && echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive users found on the system\n - This may be a long running check\n": ${l_result_9}"
   fi

   l_result_10="$(while read -r l_user l_home; do 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - while read -r l_user l_home; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_user l_home; do: ${l_result_10}"
   fi

   l_result_11="$(if [ -d "$l_home" ]; then 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - if [ -d "$l_home" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_home" ]; then: ${l_result_11}"
   fi

   l_result_12="$(l_mask='0027' 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_mask='0027': no output (PASS)"
   else
      l_output2="$l_output2\n - l_mask='0027': ${l_result_12}"
   fi

   l_result_13="$(l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )": ${l_result_13}"
   fi

   l_result_14="$(while read -r l_own l_mode; do 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - while read -r l_own l_mode; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_own l_mode; do: ${l_result_14}"
   fi

   l_result_15="$([ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\"" 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\"": ${l_result_15}"
   fi

   l_result_16="$(if [ $(( $l_mode & $l_mask )) -gt 0 ]; then 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - if [ $(( $l_mode & $l_mask )) -gt 0 ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ $(( $l_mode & $l_mask )) -gt 0 ]; then: ${l_result_16}"
   fi

   l_result_17="$(l_haout2="$l_haout2\n - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_haout2="$l_haout2\n - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - l_haout2="$l_haout2\n - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive": ${l_result_17}"
   fi

   l_result_18="$(done <<< "$(stat -Lc '%U %#a' "$l_home")" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - done <<< "$(stat -Lc '%U %#a' "$l_home")": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(stat -Lc '%U %#a' "$l_home")": ${l_result_18}"
   fi

   l_result_19="$(else 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_19}"
   fi

   l_result_20="$(l_heout2="$l_heout2\n - User: \"$l_user\" Home \"$l_home\" Doesn't exist" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - l_heout2="$l_heout2\n - User: \"$l_user\" Home \"$l_home\" Doesn't exist": no output (PASS)"
   else
      l_output2="$l_output2\n - l_heout2="$l_heout2\n - User: \"$l_user\" Home \"$l_home\" Doesn't exist": ${l_result_20}"
   fi

   l_result_21="$(done <<< "$(printf '%s\n' "${a_uarr[@]}")" 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - done <<< "$(printf '%s\n' "${a_uarr[@]}")": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(printf '%s\n' "${a_uarr[@]}")": ${l_result_21}"
   fi

   l_result_22="$([ -z "$l_heout2" ] && l_output="$l_output\n - home directories exist" || l_output2="$l_output2$l_heout2" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - [ -z "$l_heout2" ] && l_output="$l_output\n - home directories exist" || l_output2="$l_output2$l_heout2": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_heout2" ] && l_output="$l_output\n - home directories exist" || l_output2="$l_output2$l_heout2": ${l_result_22}"
   fi

   l_result_23="$([ -z "$l_hoout2" ] && l_output="$l_output\n - own their home directory" || l_output2="$l_output2$l_hoout2" 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - [ -z "$l_hoout2" ] && l_output="$l_output\n - own their home directory" || l_output2="$l_output2$l_hoout2": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_hoout2" ] && l_output="$l_output\n - own their home directory" || l_output2="$l_output2$l_hoout2": ${l_result_23}"
   fi

   l_result_24="$([ -z "$l_haout2" ] && l_output="$l_output\n - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - [ -z "$l_haout2" ] && l_output="$l_output\n - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_haout2" ] && l_output="$l_output\n - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2": ${l_result_24}"
   fi

   l_result_25="$([ -n "$l_output" ] && l_output=" - All local interactive users:$l_output" 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && l_output=" - All local interactive users:$l_output": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && l_output=" - All local interactive users:$l_output": ${l_result_25}"
   fi

   l_result_26="$(if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass: ${l_result_26}"
   fi

   l_result_27="$(echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output": ${l_result_27}"
   fi

   l_result_28="$(else 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_28}"
   fi

   l_result_29="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": ${l_result_29}"
   fi

   l_result_30="$([ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output" 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output": ${l_result_30}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
