#!/bin/bash
# RHL9-132 | Ensure permissions on /etc/ssh/sshd_config are configured

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

   l_result_3="$(perm_mask='0177' && maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - perm_mask='0177' && maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0177' && maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_3}"
   fi

   l_result_4="$(SSHD_FILES_CHK() 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - SSHD_FILES_CHK(): no output (PASS)"
   else
      l_output2="$l_output2\n - SSHD_FILES_CHK(): ${l_result_4}"
   fi

   l_result_5="$(while IFS=: read -r l_mode l_user l_group; do 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - while IFS=: read -r l_mode l_user l_group; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS=: read -r l_mode l_user l_group; do: ${l_result_5}"
   fi

   l_result_6="$(l_out2="" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_out2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="": ${l_result_6}"
   fi

   l_result_7="$([ $(( $l_mode & $perm_mask )) -gt 0 ] && l_out2="$l_out2\n - Is mode: \"$l_mode\" should be: \"$maxperm\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - [ $(( $l_mode & $perm_mask )) -gt 0 ] && l_out2="$l_out2\n - Is mode: \"$l_mode\" should be: \"$maxperm\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - [ $(( $l_mode & $perm_mask )) -gt 0 ] && l_out2="$l_out2\n - Is mode: \"$l_mode\" should be: \"$maxperm\" or more restrictive": ${l_result_7}"
   fi

   l_result_8="$([ "$l_user" != "root" ] && l_out2="$l_out2\n - Is owned by \"$l_user\" should be owned by \"root\"" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - [ "$l_user" != "root" ] && l_out2="$l_out2\n - Is owned by \"$l_user\" should be owned by \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_user" != "root" ] && l_out2="$l_out2\n - Is owned by \"$l_user\" should be owned by \"root\"": ${l_result_8}"
   fi

   l_result_9="$([ "$l_group" != "root" ] && l_out2="$l_out2\n - Is group owned by \"$l_user\" should be group owned by \"root\"" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - [ "$l_group" != "root" ] && l_out2="$l_out2\n - Is group owned by \"$l_user\" should be group owned by \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_group" != "root" ] && l_out2="$l_out2\n - Is group owned by \"$l_user\" should be group owned by \"root\"": ${l_result_9}"
   fi

   l_result_10="$(if [ -n "$l_out2" ]; then 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - if [ -n "$l_out2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_out2" ]; then: ${l_result_10}"
   fi

   l_result_11="$(l_output2="$l_output2\n - File: \"$l_file\":$l_out2" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - File: \"$l_file\":$l_out2": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - File: \"$l_file\":$l_out2": ${l_result_11}"
   fi

   l_result_12="$(else 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_12}"
   fi

   l_result_13="$(l_output="$l_output\n - File: \"$l_file\":\n - Correct: mode ($l_mode), owner ($l_user), and group owner ($l_group) configured" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - File: \"$l_file\":\n - Correct: mode ($l_mode), owner ($l_user), and group owner ($l_group) configured": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - File: \"$l_file\":\n - Correct: mode ($l_mode), owner ($l_user), and group owner ($l_group) configured": ${l_result_13}"
   fi

   l_result_14="$(done < <(stat -Lc '%#a:%U:%G' "$l_file") 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - done < <(stat -Lc '%#a:%U:%G' "$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(stat -Lc '%#a:%U:%G' "$l_file"): ${l_result_14}"
   fi

   l_result_15="$([ -e "/etc/ssh/sshd_config" ] && l_file="/etc/ssh/sshd_config" && SSHD_FILES_CHK 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - [ -e "/etc/ssh/sshd_config" ] && l_file="/etc/ssh/sshd_config" && SSHD_FILES_CHK: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "/etc/ssh/sshd_config" ] && l_file="/etc/ssh/sshd_config" && SSHD_FILES_CHK: ${l_result_15}"
   fi

   l_result_16="$(while IFS= read -r -d $'\0' l_file; do 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_file; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_file; do: ${l_result_16}"
   fi

   l_result_17="$([ -e "$l_file" ] && SSHD_FILES_CHK 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - [ -e "$l_file" ] && SSHD_FILES_CHK: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "$l_file" ] && SSHD_FILES_CHK: ${l_result_17}"
   fi

   l_result_18="$(done < <(find -L /etc/ssh/sshd_config.d -type f \( -perm /077 -o ! -user root -o ! -group root \) -print0 2>/dev/null) 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - done < <(find -L /etc/ssh/sshd_config.d -type f \( -perm /077 -o ! -user root -o ! -group root \) -print0 2>/dev/null): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find -L /etc/ssh/sshd_config.d -type f \( -perm /077 -o ! -user root -o ! -group root \) -print0 2>/dev/null): ${l_result_18}"
   fi

   l_result_19="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_19}"
   fi

   l_result_20="$(echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n": ${l_result_20}"
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

   l_result_23="$([ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n": ${l_result_23}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
