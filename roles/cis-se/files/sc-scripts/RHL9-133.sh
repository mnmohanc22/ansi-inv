#!/bin/bash
# RHL9-133 | Ensure permissions on SSH private host key files are configured

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

   l_result_3="$(l_ssh_group_name="$(awk -F: '($1 ~ /^(ssh_keys|_?ssh)$/) {print $1}' /etc/group)" 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - l_ssh_group_name="$(awk -F: '($1 ~ /^(ssh_keys|_?ssh)$/) {print $1}' /etc/group)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ssh_group_name="$(awk -F: '($1 ~ /^(ssh_keys|_?ssh)$/) {print $1}' /etc/group)": ${l_result_3}"
   fi

   l_result_4="$(f_file_chk() 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - f_file_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - f_file_chk(): ${l_result_4}"
   fi

   l_result_5="$(while IFS=: read -r l_file_mode l_file_owner l_file_group; do 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - while IFS=: read -r l_file_mode l_file_owner l_file_group; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS=: read -r l_file_mode l_file_owner l_file_group; do: ${l_result_5}"
   fi

   l_result_6="$(l_out2="" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_out2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="": ${l_result_6}"
   fi

   l_result_7="$([ "$l_file_group" = "$l_ssh_group_name" ] && l_pmask="0137" || l_pmask="0177" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - [ "$l_file_group" = "$l_ssh_group_name" ] && l_pmask="0137" || l_pmask="0177": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_file_group" = "$l_ssh_group_name" ] && l_pmask="0137" || l_pmask="0177": ${l_result_7}"
   fi

   l_result_8="$(l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )": no output (PASS)"
   else
      l_output2="$l_output2\n - l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )": ${l_result_8}"
   fi

   l_result_9="$(if [ $(( $l_file_mode & $l_pmask )) -gt 0 ]; then 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - if [ $(( $l_file_mode & $l_pmask )) -gt 0 ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ $(( $l_file_mode & $l_pmask )) -gt 0 ]; then: ${l_result_9}"
   fi

   l_result_10="$(l_out2="$l_out2\n - Mode: \"$l_file_mode\" should be mode: \"$l_maxperm\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_out2="$l_out2\n - Mode: \"$l_file_mode\" should be mode: \"$l_maxperm\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="$l_out2\n - Mode: \"$l_file_mode\" should be mode: \"$l_maxperm\" or more restrictive": ${l_result_10}"
   fi

   l_result_11="$(if [ "$l_file_owner" != "root" ]; then 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - if [ "$l_file_owner" != "root" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_file_owner" != "root" ]; then: ${l_result_11}"
   fi

   l_result_12="$(l_out2="$l_out2\n - Owned by: \"$l_file_owner\" should be owned by \"root\"" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_out2="$l_out2\n - Owned by: \"$l_file_owner\" should be owned by \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="$l_out2\n - Owned by: \"$l_file_owner\" should be owned by \"root\"": ${l_result_12}"
   fi

   l_result_13="$(if [[ ! "$l_file_group" =~ ($l_ssh_group_name|root) ]]; then 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - if [[ ! "$l_file_group" =~ ($l_ssh_group_name|root) ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ ! "$l_file_group" =~ ($l_ssh_group_name|root) ]]; then: ${l_result_13}"
   fi

   l_result_14="$(l_out2="$l_out2\n - Owned by group \"$l_file_group\" should be group owned by: \"$l_ssh_group_name\" or \"root\"" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - l_out2="$l_out2\n - Owned by group \"$l_file_group\" should be group owned by: \"$l_ssh_group_name\" or \"root\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_out2="$l_out2\n - Owned by group \"$l_file_group\" should be group owned by: \"$l_ssh_group_name\" or \"root\"": ${l_result_14}"
   fi

   l_result_15="$(if [ -n "$l_out2" ]; then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if [ -n "$l_out2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_out2" ]; then: ${l_result_15}"
   fi

   l_result_16="$(l_output2="$l_output2\n - File: \"$l_file\"$l_out2" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - File: \"$l_file\"$l_out2": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - File: \"$l_file\"$l_out2": ${l_result_16}"
   fi

   l_result_17="$(else 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_17}"
   fi

   l_result_18="$(l_output="$l_output\n - File: \"$l_file\"\n - Correct: mode: \"$l_file_mode\", owner: \"$l_file_owner\", and group owner: \"$l_file_group\" configured" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - File: \"$l_file\"\n - Correct: mode: \"$l_file_mode\", owner: \"$l_file_owner\", and group owner: \"$l_file_group\" configured": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - File: \"$l_file\"\n - Correct: mode: \"$l_file_mode\", owner: \"$l_file_owner\", and group owner: \"$l_file_group\" configured": ${l_result_18}"
   fi

   l_result_19="$(done < <(stat -Lc '%#a:%U:%G' "$l_file") 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - done < <(stat -Lc '%#a:%U:%G' "$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(stat -Lc '%#a:%U:%G' "$l_file"): ${l_result_19}"
   fi

   l_result_20="$(while IFS= read -r -d $'\0' l_file; do 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_file; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_file; do: ${l_result_20}"
   fi

   l_result_21="$(if ssh-keygen -lf &>/dev/null "$l_file"; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if ssh-keygen -lf &>/dev/null "$l_file"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ssh-keygen -lf &>/dev/null "$l_file"; then: ${l_result_21}"
   fi

   l_result_22="$(file "$l_file" | grep -Piq -- '\bopenssh\h+([^#\n\r]+\h+)?private\h+key\b' && f_file_chk 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - file "$l_file" | grep -Piq -- '\bopenssh\h+([^#\n\r]+\h+)?private\h+key\b' && f_file_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file "$l_file" | grep -Piq -- '\bopenssh\h+([^#\n\r]+\h+)?private\h+key\b' && f_file_chk: ${l_result_22}"
   fi

   l_result_23="$(done < <(find -L /etc/ssh -xdev -type f -print0 2>/dev/null) 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - done < <(find -L /etc/ssh -xdev -type f -print0 2>/dev/null): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find -L /etc/ssh -xdev -type f -print0 2>/dev/null): ${l_result_23}"
   fi

   l_result_24="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_24}"
   fi

   l_result_25="$([ -z "$l_output" ] && l_output="\n - No openSSH private keys found" 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_output="\n - No openSSH private keys found": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_output="\n - No openSSH private keys found": ${l_result_25}"
   fi

   l_result_26="$(echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :$l_output" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :$l_output": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :$l_output": ${l_result_26}"
   fi

   l_result_27="$(else 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_27}"
   fi

   l_result_28="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :$l_output2\n": ${l_result_28}"
   fi

   l_result_29="$([ -n "$l_output" ] && echo -e "\n - * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n - * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n - * Correctly configured * :\n$l_output\n": ${l_result_29}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
