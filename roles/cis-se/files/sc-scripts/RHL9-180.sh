#!/bin/bash
# RHL9-180 | Ensure world writable files and directories are secured

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

   l_result_3="$(l_smask='01000' 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - l_smask='01000': no output (PASS)"
   else
      l_output2="$l_output2\n - l_smask='01000': ${l_result_3}"
   fi

   l_result_4="$(a_file=(); a_dir=() # Initialize arrays 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - a_file=(); a_dir=() # Initialize arrays: no output (PASS)"
   else
      l_output2="$l_output2\n - a_file=(); a_dir=() # Initialize arrays: ${l_result_4}"
   fi

   l_result_5="$(a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "*/kubelet/plugins/*" -a ! -path "/sys/*" -a ! -path "/snap/*") 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "*/kubelet/plugins/*" -a ! -path "/sys/*" -a ! -path "/snap/*"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "*/kubelet/plugins/*" -a ! -path "/sys/*" -a ! -path "/snap/*"): ${l_result_5}"
   fi

   l_result_6="$(while IFS= read -r l_mount; do 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - while IFS= read -r l_mount; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r l_mount; do: ${l_result_6}"
   fi

   l_result_7="$(while IFS= read -r -d $'\0' l_file; do 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_file; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_file; do: ${l_result_7}"
   fi

   l_result_8="$(if [ -e "$l_file" ]; then 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - if [ -e "$l_file" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -e "$l_file" ]; then: ${l_result_8}"
   fi

   l_result_9="$([ -f "$l_file" ] && a_file+=("$l_file") # Add WR files 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - [ -f "$l_file" ] && a_file+=("$l_file") # Add WR files: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -f "$l_file" ] && a_file+=("$l_file") # Add WR files: ${l_result_9}"
   fi

   l_result_10="$(if [ -d "$l_file" ]; then # Add directories w/o sticky bit 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - if [ -d "$l_file" ]; then # Add directories w/o sticky bit: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_file" ]; then # Add directories w/o sticky bit: ${l_result_10}"
   fi

   l_result_11="$(l_mode="$(stat -Lc '%#a' "$l_file")" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - l_mode="$(stat -Lc '%#a' "$l_file")": no output (PASS)"
   else
      l_output2="$l_output2\n - l_mode="$(stat -Lc '%#a' "$l_file")": ${l_result_11}"
   fi

   l_result_12="$([ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_file") 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - [ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - [ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_file"): ${l_result_12}"
   fi

   l_result_13="$(done < <(find "$l_mount" -xdev \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2> /dev/null) 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - done < <(find "$l_mount" -xdev \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2> /dev/null): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find "$l_mount" -xdev \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2> /dev/null): ${l_result_13}"
   fi

   l_result_14="$(done < <(findmnt -Dkerno fstype,target | awk '($1 !~ /^\s*(nfs|proc|smb|vfat|iso9660|efivarfs|selinuxfs)/ && $2 !~ /^(\/run\/user\/|\/tmp|\/var\/tmp)/){print $2}') 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - done < <(findmnt -Dkerno fstype,target | awk '($1 !~ /^\s*(nfs|proc|smb|vfat|iso9660|efivarfs|selinuxfs)/ && $2 !~ /^(\/run\/user\/|\/tmp|\/var\/tmp)/){print $2}'): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(findmnt -Dkerno fstype,target | awk '($1 !~ /^\s*(nfs|proc|smb|vfat|iso9660|efivarfs|selinuxfs)/ && $2 !~ /^(\/run\/user\/|\/tmp|\/var\/tmp)/){print $2}'): ${l_result_14}"
   fi

   l_result_15="$(if ! (( ${#a_file[@]} > 0 )); then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if ! (( ${#a_file[@]} > 0 )); then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ! (( ${#a_file[@]} > 0 )); then: ${l_result_15}"
   fi

   l_result_16="$(l_output="$l_output\n - No world writable files exist on the local filesystem." 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - No world writable files exist on the local filesystem.": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - No world writable files exist on the local filesystem.": ${l_result_16}"
   fi

   l_result_17="$(else 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_17}"
   fi

   l_result_18="$(l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" World writable files on the system.\n - The following is a list of World writable files:\n$(printf '%s\n' "${a_file[@]}")\n - end of list\n" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" World writable files on the system.\n - The following is a list of World writable files:\n$(printf '%s\n' "${a_file[@]}")\n - end of list\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" World writable files on the system.\n - The following is a list of World writable files:\n$(printf '%s\n' "${a_file[@]}")\n - end of list\n": ${l_result_18}"
   fi

   l_result_19="$(if ! (( ${#a_dir[@]} > 0 )); then 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - if ! (( ${#a_dir[@]} > 0 )); then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ! (( ${#a_dir[@]} > 0 )); then: ${l_result_19}"
   fi

   l_result_20="$(l_output="$l_output\n - Sticky bit is set on world writable directories on the local filesystem." 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - Sticky bit is set on world writable directories on the local filesystem.": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - Sticky bit is set on world writable directories on the local filesystem.": ${l_result_20}"
   fi

   l_result_21="$(else 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_21}"
   fi

   l_result_22="$(l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" World writable directories without the sticky bit on the system.\n - The following is a list of World writable directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n - end of list\n" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" World writable directories without the sticky bit on the system.\n - The following is a list of World writable directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n - end of list\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" World writable directories without the sticky bit on the system.\n - The following is a list of World writable directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n - end of list\n": ${l_result_22}"
   fi

   l_result_23="$(unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays: ${l_result_23}"
   fi

   l_result_24="$(If l_output2 is empty, we pass 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - If l_output2 is empty, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - If l_output2 is empty, we pass: ${l_result_24}"
   fi

   l_result_25="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_25}"
   fi

   l_result_26="$(echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n": ${l_result_26}"
   fi

   l_result_27="$(else 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_27}"
   fi

   l_result_28="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": ${l_result_28}"
   fi

   l_result_29="$([ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n": ${l_result_29}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
