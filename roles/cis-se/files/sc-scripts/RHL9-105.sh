#!/bin/bash
# RHL9-105 | Ensure access to all logfiles has been configured

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_op2="" l_output2="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_op2="" l_output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_op2="" l_output2="": ${l_result_2}"
   fi

   l_result_3="$(l_uidmin="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)" 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - l_uidmin="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_uidmin="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)": ${l_result_3}"
   fi

   l_result_4="$(file_test_chk() 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - file_test_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk(): ${l_result_4}"
   fi

   l_result_5="$(l_op2="" 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - l_op2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_op2="": ${l_result_5}"
   fi

   l_result_6="$(if [ $(( $l_mode & $perm_mask )) -gt 0 ]; then 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - if [ $(( $l_mode & $perm_mask )) -gt 0 ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ $(( $l_mode & $perm_mask )) -gt 0 ]; then: ${l_result_6}"
   fi

   l_result_7="$(l_op2="$l_op2\n - Mode: \"$l_mode\" should be \"$maxperm\" or more restrictive" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - l_op2="$l_op2\n - Mode: \"$l_mode\" should be \"$maxperm\" or more restrictive": no output (PASS)"
   else
      l_output2="$l_output2\n - l_op2="$l_op2\n - Mode: \"$l_mode\" should be \"$maxperm\" or more restrictive": ${l_result_7}"
   fi

   l_result_8="$(if [[ ! "$l_user" =~ $l_auser ]]; then 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - if [[ ! "$l_user" =~ $l_auser ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ ! "$l_user" =~ $l_auser ]]; then: ${l_result_8}"
   fi

   l_result_9="$(l_op2="$l_op2\n - Owned by: \"$l_user\" and should be owned by \"${l_auser//|/ or }\"" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - l_op2="$l_op2\n - Owned by: \"$l_user\" and should be owned by \"${l_auser//|/ or }\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_op2="$l_op2\n - Owned by: \"$l_user\" and should be owned by \"${l_auser//|/ or }\"": ${l_result_9}"
   fi

   l_result_10="$(if [[ ! "$l_group" =~ $l_agroup ]]; then 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - if [[ ! "$l_group" =~ $l_agroup ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ ! "$l_group" =~ $l_agroup ]]; then: ${l_result_10}"
   fi

   l_result_11="$(l_op2="$l_op2\n - Group owned by: \"$l_group\" and should be group owned by \"${l_agroup//|/ or }\"" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - l_op2="$l_op2\n - Group owned by: \"$l_group\" and should be group owned by \"${l_agroup//|/ or }\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_op2="$l_op2\n - Group owned by: \"$l_group\" and should be group owned by \"${l_agroup//|/ or }\"": ${l_result_11}"
   fi

   l_result_12="$([ -n "$l_op2" ] && l_output2="$l_output2\n - File: \"$l_fname\" is:$l_op2\n" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - [ -n "$l_op2" ] && l_output2="$l_output2\n - File: \"$l_fname\" is:$l_op2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_op2" ] && l_output2="$l_output2\n - File: \"$l_fname\" is:$l_op2\n": ${l_result_12}"
   fi

   l_result_13="$(unset a_file && a_file=() # clear and initialize array 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - unset a_file && a_file=() # clear and initialize array: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_file && a_file=() # clear and initialize array: ${l_result_13}"
   fi

   l_result_14="$(Loop to create array with stat of files that could possibly fail one of the audits 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - Loop to create array with stat of files that could possibly fail one of the audits: no output (PASS)"
   else
      l_output2="$l_output2\n - Loop to create array with stat of files that could possibly fail one of the audits: ${l_result_14}"
   fi

   l_result_15="$(while IFS= read -r -d $'\0' l_file; do 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_file; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_file; do: ${l_result_15}"
   fi

   l_result_16="$([ -e "$l_file" ] && a_file+=("$(stat -Lc '%n^%#a^%U^%u^%G^%g' "$l_file")") 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - [ -e "$l_file" ] && a_file+=("$(stat -Lc '%n^%#a^%U^%u^%G^%g' "$l_file")"): no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "$l_file" ] && a_file+=("$(stat -Lc '%n^%#a^%U^%u^%G^%g' "$l_file")"): ${l_result_16}"
   fi

   l_result_17="$(done < <(find -L /var/log -type f \( -perm /0137 -o ! -user root -o ! -group root \) -print0) 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - done < <(find -L /var/log -type f \( -perm /0137 -o ! -user root -o ! -group root \) -print0): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find -L /var/log -type f \( -perm /0137 -o ! -user root -o ! -group root \) -print0): ${l_result_17}"
   fi

   l_result_18="$(while IFS="^" read -r l_fname l_mode l_user l_uid l_group l_gid; do 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - while IFS="^" read -r l_fname l_mode l_user l_uid l_group l_gid; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS="^" read -r l_fname l_mode l_user l_uid l_group l_gid; do: ${l_result_18}"
   fi

   l_result_19="$(l_bname="$(basename "$l_fname")" 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_bname="$(basename "$l_fname")": no output (PASS)"
   else
      l_output2="$l_output2\n - l_bname="$(basename "$l_fname")": ${l_result_19}"
   fi

   l_result_20="$(case "$l_bname" in 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - case "$l_bname" in: no output (PASS)"
   else
      l_output2="$l_output2\n - case "$l_bname" in: ${l_result_20}"
   fi

   l_result_21="$(lastlog | lastlog.* | wtmp | wtmp.* | wtmp-* | btmp | btmp.* | btmp-* | README) 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - lastlog | lastlog.* | wtmp | wtmp.* | wtmp-* | btmp | btmp.* | btmp-* | README): no output (PASS)"
   else
      l_output2="$l_output2\n - lastlog | lastlog.* | wtmp | wtmp.* | wtmp-* | btmp | btmp.* | btmp-* | README): ${l_result_21}"
   fi

   l_result_22="$(perm_mask='0113' 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - perm_mask='0113': no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0113': ${l_result_22}"
   fi

   l_result_23="$(maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_23}"
   fi

   l_result_24="$(l_auser="root" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_auser="root": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="root": ${l_result_24}"
   fi

   l_result_25="$(l_agroup="(root|utmp)" 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - l_agroup="(root|utmp)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_agroup="(root|utmp)": ${l_result_25}"
   fi

   l_result_26="$(file_test_chk 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - file_test_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk: ${l_result_26}"
   fi

   l_result_27="$(secure | auth.log | syslog | messages) 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - secure | auth.log | syslog | messages): no output (PASS)"
   else
      l_output2="$l_output2\n - secure | auth.log | syslog | messages): ${l_result_27}"
   fi

   l_result_28="$(perm_mask='0137' 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - perm_mask='0137': no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0137': ${l_result_28}"
   fi

   l_result_29="$(maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_29}"
   fi

   l_result_30="$(l_auser="(root|syslog)" 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - l_auser="(root|syslog)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="(root|syslog)": ${l_result_30}"
   fi

   l_result_31="$(l_agroup="(root|adm)" 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - l_agroup="(root|adm)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_agroup="(root|adm)": ${l_result_31}"
   fi

   l_result_32="$(file_test_chk 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - file_test_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk: ${l_result_32}"
   fi

   l_result_33="$(SSSD | sssd) 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - SSSD | sssd): no output (PASS)"
   else
      l_output2="$l_output2\n - SSSD | sssd): ${l_result_33}"
   fi

   l_result_34="$(perm_mask='0117' 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - perm_mask='0117': no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0117': ${l_result_34}"
   fi

   l_result_35="$(maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_35}" ]; then
      l_output="$l_output\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_35}"
   fi

   l_result_36="$(l_auser="(root|SSSD)" 2>/dev/null)"
   if [ -z "${l_result_36}" ]; then
      l_output="$l_output\n - l_auser="(root|SSSD)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="(root|SSSD)": ${l_result_36}"
   fi

   l_result_37="$(l_agroup="(root|SSSD)" 2>/dev/null)"
   if [ -z "${l_result_37}" ]; then
      l_output="$l_output\n - l_agroup="(root|SSSD)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_agroup="(root|SSSD)": ${l_result_37}"
   fi

   l_result_38="$(file_test_chk 2>/dev/null)"
   if [ -z "${l_result_38}" ]; then
      l_output="$l_output\n - file_test_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk: ${l_result_38}"
   fi

   l_result_39="$(gdm | gdm3) 2>/dev/null)"
   if [ -z "${l_result_39}" ]; then
      l_output="$l_output\n - gdm | gdm3): no output (PASS)"
   else
      l_output2="$l_output2\n - gdm | gdm3): ${l_result_39}"
   fi

   l_result_40="$(perm_mask='0117' 2>/dev/null)"
   if [ -z "${l_result_40}" ]; then
      l_output="$l_output\n - perm_mask='0117': no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0117': ${l_result_40}"
   fi

   l_result_41="$(maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_41}" ]; then
      l_output="$l_output\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_41}"
   fi

   l_result_42="$(l_auser="root" 2>/dev/null)"
   if [ -z "${l_result_42}" ]; then
      l_output="$l_output\n - l_auser="root": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="root": ${l_result_42}"
   fi

   l_result_43="$(l_agroup="(root|gdm|gdm3)" 2>/dev/null)"
   if [ -z "${l_result_43}" ]; then
      l_output="$l_output\n - l_agroup="(root|gdm|gdm3)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_agroup="(root|gdm|gdm3)": ${l_result_43}"
   fi

   l_result_44="$(file_test_chk 2>/dev/null)"
   if [ -z "${l_result_44}" ]; then
      l_output="$l_output\n - file_test_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk: ${l_result_44}"
   fi

   l_result_45="$(*.journal | *.journal~) 2>/dev/null)"
   if [ -z "${l_result_45}" ]; then
      l_output="$l_output\n - *.journal | *.journal~): no output (PASS)"
   else
      l_output2="$l_output2\n - *.journal | *.journal~): ${l_result_45}"
   fi

   l_result_46="$(perm_mask='0137' 2>/dev/null)"
   if [ -z "${l_result_46}" ]; then
      l_output="$l_output\n - perm_mask='0137': no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0137': ${l_result_46}"
   fi

   l_result_47="$(maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_47}" ]; then
      l_output="$l_output\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_47}"
   fi

   l_result_48="$(l_auser="root" 2>/dev/null)"
   if [ -z "${l_result_48}" ]; then
      l_output="$l_output\n - l_auser="root": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="root": ${l_result_48}"
   fi

   l_result_49="$(l_agroup="(root|systemd-journal)" 2>/dev/null)"
   if [ -z "${l_result_49}" ]; then
      l_output="$l_output\n - l_agroup="(root|systemd-journal)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_agroup="(root|systemd-journal)": ${l_result_49}"
   fi

   l_result_50="$(file_test_chk 2>/dev/null)"
   if [ -z "${l_result_50}" ]; then
      l_output="$l_output\n - file_test_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk: ${l_result_50}"
   fi

   l_result_51="$(perm_mask='0137' 2>/dev/null)"
   if [ -z "${l_result_51}" ]; then
      l_output="$l_output\n - perm_mask='0137': no output (PASS)"
   else
      l_output2="$l_output2\n - perm_mask='0137': ${l_result_51}"
   fi

   l_result_52="$(maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )" 2>/dev/null)"
   if [ -z "${l_result_52}" ]; then
      l_output="$l_output\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": no output (PASS)"
   else
      l_output2="$l_output2\n - maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )": ${l_result_52}"
   fi

   l_result_53="$(l_auser="(root|syslog)" 2>/dev/null)"
   if [ -z "${l_result_53}" ]; then
      l_output="$l_output\n - l_auser="(root|syslog)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="(root|syslog)": ${l_result_53}"
   fi

   l_result_54="$(l_agroup="(root|adm)" 2>/dev/null)"
   if [ -z "${l_result_54}" ]; then
      l_output="$l_output\n - l_agroup="(root|adm)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_agroup="(root|adm)": ${l_result_54}"
   fi

   l_result_55="$(if [ "$l_uid" -lt "$l_uidmin" ] && [ -z "$(awk -v grp="$l_group" -F: '$1==grp {print $4}' /etc/group)" ]; then 2>/dev/null)"
   if [ -z "${l_result_55}" ]; then
      l_output="$l_output\n - if [ "$l_uid" -lt "$l_uidmin" ] && [ -z "$(awk -v grp="$l_group" -F: '$1==grp {print $4}' /etc/group)" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_uid" -lt "$l_uidmin" ] && [ -z "$(awk -v grp="$l_group" -F: '$1==grp {print $4}' /etc/group)" ]; then: ${l_result_55}"
   fi

   l_result_56="$(if [[ ! "$l_user" =~ $l_auser ]]; then 2>/dev/null)"
   if [ -z "${l_result_56}" ]; then
      l_output="$l_output\n - if [[ ! "$l_user" =~ $l_auser ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ ! "$l_user" =~ $l_auser ]]; then: ${l_result_56}"
   fi

   l_result_57="$(l_auser="(root|syslog|$l_user)" 2>/dev/null)"
   if [ -z "${l_result_57}" ]; then
      l_output="$l_output\n - l_auser="(root|syslog|$l_user)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_auser="(root|syslog|$l_user)": ${l_result_57}"
   fi

   l_result_58="$(if [[ ! "$l_group" =~ $l_agroup ]]; then 2>/dev/null)"
   if [ -z "${l_result_58}" ]; then
      l_output="$l_output\n - if [[ ! "$l_group" =~ $l_agroup ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ ! "$l_group" =~ $l_agroup ]]; then: ${l_result_58}"
   fi

   l_result_59="$(l_tst="" 2>/dev/null)"
   if [ -z "${l_result_59}" ]; then
      l_output="$l_output\n - l_tst="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_tst="": ${l_result_59}"
   fi

   l_result_60="$(while l_out3="" read -r l_duid; do 2>/dev/null)"
   if [ -z "${l_result_60}" ]; then
      l_output="$l_output\n - while l_out3="" read -r l_duid; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while l_out3="" read -r l_duid; do: ${l_result_60}"
   fi

   l_result_61="$([ "$l_duid" -ge "$l_uidmin" ] && l_tst=failed 2>/dev/null)"
   if [ -z "${l_result_61}" ]; then
      l_output="$l_output\n - [ "$l_duid" -ge "$l_uidmin" ] && l_tst=failed: no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_duid" -ge "$l_uidmin" ] && l_tst=failed: ${l_result_61}"
   fi

   l_result_62="$(done <<< "$(awk -F: '$4=='"$l_gid"' {print $3}' /etc/passwd)" 2>/dev/null)"
   if [ -z "${l_result_62}" ]; then
      l_output="$l_output\n - done <<< "$(awk -F: '$4=='"$l_gid"' {print $3}' /etc/passwd)": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(awk -F: '$4=='"$l_gid"' {print $3}' /etc/passwd)": ${l_result_62}"
   fi

   l_result_63="$([ "$l_tst" != "failed" ] && l_agroup="(root|adm|$l_group)" 2>/dev/null)"
   if [ -z "${l_result_63}" ]; then
      l_output="$l_output\n - [ "$l_tst" != "failed" ] && l_agroup="(root|adm|$l_group)": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_tst" != "failed" ] && l_agroup="(root|adm|$l_group)": ${l_result_63}"
   fi

   l_result_64="$(file_test_chk 2>/dev/null)"
   if [ -z "${l_result_64}" ]; then
      l_output="$l_output\n - file_test_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_test_chk: ${l_result_64}"
   fi

   l_result_65="$(esac 2>/dev/null)"
   if [ -z "${l_result_65}" ]; then
      l_output="$l_output\n - esac: no output (PASS)"
   else
      l_output2="$l_output2\n - esac: ${l_result_65}"
   fi

   l_result_66="$(done <<< "$(printf '%s\n' "${a_file[@]}")" 2>/dev/null)"
   if [ -z "${l_result_66}" ]; then
      l_output="$l_output\n - done <<< "$(printf '%s\n' "${a_file[@]}")": no output (PASS)"
   else
      l_output2="$l_output2\n - done <<< "$(printf '%s\n' "${a_file[@]}")": ${l_result_66}"
   fi

   l_result_67="$(unset a_file # Clear array 2>/dev/null)"
   if [ -z "${l_result_67}" ]; then
      l_output="$l_output\n - unset a_file # Clear array: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_file # Clear array: ${l_result_67}"
   fi

   l_result_68="$(If all files passed, then we pass 2>/dev/null)"
   if [ -z "${l_result_68}" ]; then
      l_output="$l_output\n - If all files passed, then we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - If all files passed, then we pass: ${l_result_68}"
   fi

   l_result_69="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_69}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_69}"
   fi

   l_result_70="$(echo -e "\n- Audit Results:\n ** Pass **\n- All files in \"/var/log/\" have appropriate permissions and ownership\n" 2>/dev/null)"
   if [ -z "${l_result_70}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Results:\n ** Pass **\n- All files in \"/var/log/\" have appropriate permissions and ownership\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Results:\n ** Pass **\n- All files in \"/var/log/\" have appropriate permissions and ownership\n": ${l_result_70}"
   fi

   l_result_71="$(else 2>/dev/null)"
   if [ -z "${l_result_71}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_71}"
   fi

   l_result_72="$(print the reason why we are failing 2>/dev/null)"
   if [ -z "${l_result_72}" ]; then
      l_output="$l_output\n - print the reason why we are failing: no output (PASS)"
   else
      l_output2="$l_output2\n - print the reason why we are failing: ${l_result_72}"
   fi

   l_result_73="$(echo -e "\n- Audit Results:\n ** Fail **\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_73}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Results:\n ** Fail **\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Results:\n ** Fail **\n$l_output2": ${l_result_73}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
