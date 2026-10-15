#!/bin/bash
# RHL9-32 | Ensure access to bootloader config is configured

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="": ${l_result_2}"
   fi

   l_result_3="$(file_mug_chk() 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - file_mug_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - file_mug_chk(): ${l_result_3}"
   fi

   l_result_4="$(l_out="" l_out2="" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_out="" l_out2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out="" l_out2="": ${l_result_4}"
   fi

   l_result_5="$([[ "$(dirname "$l_file")" =~ ^\/boot\/efi\/EFI ]] && l_pmask="0077" || l_pmask="0177" 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - [[ "$(dirname "$l_file")" =~ ^\/boot\/efi\/EFI ]] && l_pmask="0077" || l_pmask="0177": no output (PASS)"
   else
      l_output2="$l_output2\n - [[ "$(dirname "$l_file")" =~ ^\/boot\/efi\/EFI ]] && l_pmask="0077" || l_pmask="0177": ${l_result_5}"
   fi

   l_result_6="$(l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )": no output (PASS)"
   else
      l_output2="$l_output2\n - l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )": ${l_result_6}"
   fi

   l_result_7="$(if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then: ${l_result_7}"
   fi

   l_result_8="$(l_out2="$l_out2\n - Is mode \"$l_mode\" and should be mode: \"$l_maxperm\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - l_out2="$l_out2\n - Is mode \"$l_mode\" and should be mode: \"$l_maxperm\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="$l_out2\n - Is mode \"$l_mode\" and should be mode: \"$l_maxperm\" or more restrictive": ${l_result_8}"
   fi

   l_result_9="$(else 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_9}"
   fi

   l_result_10="$(l_out="$l_out\n - Is correctly mode: \"$l_mode\" which is mode: \"$l_maxperm\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_out="$l_out\n - Is correctly mode: \"$l_mode\" which is mode: \"$l_maxperm\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out="$l_out\n - Is correctly mode: \"$l_mode\" which is mode: \"$l_maxperm\" or more restrictive": ${l_result_10}"
   fi

   l_result_11="$(if [ "$l_user" = "root" ]; then 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - if [ "$l_user" = "root" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_user" = "root" ]; then: ${l_result_11}"
   fi

   l_result_12="$(l_out="$l_out\n - Is correctly owned by user: \"$l_user\"" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_out="$l_out\n - Is correctly owned by user: \"$l_user\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out="$l_out\n - Is correctly owned by user: \"$l_user\"": ${l_result_12}"
   fi

   l_result_13="$(else 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_13}"
   fi

   l_result_14="$(l_out2="$l_out2\n - Is owned by user: \"$l_user\" and should be owned by user: \"root\"" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - l_out2="$l_out2\n - Is owned by user: \"$l_user\" and should be owned by user: \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="$l_out2\n - Is owned by user: \"$l_user\" and should be owned by user: \"root\"": ${l_result_14}"
   fi

   l_result_15="$(if [ "$l_group" = "root" ]; then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if [ "$l_group" = "root" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_group" = "root" ]; then: ${l_result_15}"
   fi

   l_result_16="$(l_out="$l_out\n - Is correctly group-owned by group: \"$l_user\"" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_out="$l_out\n - Is correctly group-owned by group: \"$l_user\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out="$l_out\n - Is correctly group-owned by group: \"$l_user\"": ${l_result_16}"
   fi

   l_result_17="$(else 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_17}"
   fi

   l_result_18="$(l_out2="$l_out2\n - Is group-owned by group: \"$l_user\" and should be group-owned by group: \"root\"" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_out2="$l_out2\n - Is group-owned by group: \"$l_user\" and should be group-owned by group: \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="$l_out2\n - Is group-owned by group: \"$l_user\" and should be group-owned by group: \"root\"": ${l_result_18}"
   fi

   l_result_19="$([ -n "$l_out" ] && l_output="$l_output\n - File: \"$l_file\"$l_out\n" 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - [ -n "$l_out" ] && l_output="$l_output\n - File: \"$l_file\"$l_out\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_out" ] && l_output="$l_output\n - File: \"$l_file\"$l_out\n": ${l_result_19}"
   fi

   l_result_20="$([ -n "$l_out2" ] && l_output2="$l_output2\n - File: \"$l_file\"$l_out2\n" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - [ -n "$l_out2" ] && l_output2="$l_output2\n - File: \"$l_file\"$l_out2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_out2" ] && l_output2="$l_output2\n - File: \"$l_file\"$l_out2\n": ${l_result_20}"
   fi

   l_result_21="$(while IFS= read -r -d $'\0' l_gfile; do 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_gfile; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_gfile; do: ${l_result_21}"
   fi

   l_result_22="$(while read -r l_file l_mode l_user l_group; do 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - while read -r l_file l_mode l_user l_group; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_file l_mode l_user l_group; do: ${l_result_22}"
   fi

   l_result_23="$(file_mug_chk 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - file_mug_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_mug_chk: ${l_result_23}"
   fi

   l_result_24="$(done <<< "$(stat -Lc '%n %#a %U %G' "$l_gfile")" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - done <<< "$(stat -Lc '%n %#a %U %G' "$l_gfile")": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(stat -Lc '%n %#a %U %G' "$l_gfile")": ${l_result_24}"
   fi

   l_result_25="$(done < <(find /boot -type f \( -name 'grub*' -o -name 'user.cfg' \) -print0) 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - done < <(find /boot -type f \( -name 'grub*' -o -name 'user.cfg' \) -print0): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find /boot -type f \( -name 'grub*' -o -name 'user.cfg' \) -print0): ${l_result_25}"
   fi

   l_result_26="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_26}"
   fi

   l_result_27="$(echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n": ${l_result_27}"
   fi

   l_result_28="$(else 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_28}"
   fi

   l_result_29="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n": ${l_result_29}"
   fi

   l_result_30="$([ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n": ${l_result_30}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
