#!/bin/bash
# RHL9-182 | Ensure no files or directories without an owner and a group exist

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

   l_result_3="$(a_nouser=(); a_nogroup=() # Initialize arrays 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - a_nouser=(); a_nogroup=() # Initialize arrays: no output (PASS)"
   else
      l_output2="$l_output2\n - a_nouser=(); a_nogroup=() # Initialize arrays: ${l_result_3}"
   fi

   l_result_4="$(a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "*/kubelet/plugins/*" -a ! -path "/sys/fs/cgroup/memory/*" -a ! -path "/var/*/private/*") 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "*/kubelet/plugins/*" -a ! -path "/sys/fs/cgroup/memory/*" -a ! -path "/var/*/private/*"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "*/kubelet/plugins/*" -a ! -path "/sys/fs/cgroup/memory/*" -a ! -path "/var/*/private/*"): ${l_result_4}"
   fi

   l_result_5="$(while IFS= read -r l_mount; do 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - while IFS= read -r l_mount; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r l_mount; do: ${l_result_5}"
   fi

   l_result_6="$(while IFS= read -r -d $'\0' l_file; do 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_file; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_file; do: ${l_result_6}"
   fi

   l_result_7="$(if [ -e "$l_file" ]; then 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - if [ -e "$l_file" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -e "$l_file" ]; then: ${l_result_7}"
   fi

   l_result_8="$(while IFS=: read -r l_user l_group; do 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - while IFS=: read -r l_user l_group; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS=: read -r l_user l_group; do: ${l_result_8}"
   fi

   l_result_9="$([ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_file") 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - [ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_file"): ${l_result_9}"
   fi

   l_result_10="$([ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_file") 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - [ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_file"): ${l_result_10}"
   fi

   l_result_11="$(done < <(stat -Lc '%U:%G' "$l_file") 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - done < <(stat -Lc '%U:%G' "$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(stat -Lc '%U:%G' "$l_file"): ${l_result_11}"
   fi

   l_result_12="$(done < <(find "$l_mount" -xdev \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) -print0 2> /dev/null) 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - done < <(find "$l_mount" -xdev \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) -print0 2> /dev/null): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find "$l_mount" -xdev \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) -print0 2> /dev/null): ${l_result_12}"
   fi

   l_result_13="$(done < <(findmnt -Dkerno fstype,target | awk '($1 !~ /^\s*(nfs|proc|smb|vfat|iso9660|efivarfs|selinuxfs)/ && $2 !~ /^\/run\/user\//){print $2}') 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - done < <(findmnt -Dkerno fstype,target | awk '($1 !~ /^\s*(nfs|proc|smb|vfat|iso9660|efivarfs|selinuxfs)/ && $2 !~ /^\/run\/user\//){print $2}'): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(findmnt -Dkerno fstype,target | awk '($1 !~ /^\s*(nfs|proc|smb|vfat|iso9660|efivarfs|selinuxfs)/ && $2 !~ /^\/run\/user\//){print $2}'): ${l_result_13}"
   fi

   l_result_14="$(if ! (( ${#a_nouser[@]} > 0 )); then 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - if ! (( ${#a_nouser[@]} > 0 )); then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ! (( ${#a_nouser[@]} > 0 )); then: ${l_result_14}"
   fi

   l_result_15="$(l_output="$l_output\n - No files or directories without a owner exist on the local filesystem." 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - No files or directories without a owner exist on the local filesystem.": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - No files or directories without a owner exist on the local filesystem.": ${l_result_15}"
   fi

   l_result_16="$(else 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_16}"
   fi

   l_result_17="$(l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or directories on the system.\n - The following is a list of unowned files and/or directories:\n$(printf '%s\n' "${a_nouser[@]}")\n - end of list" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or directories on the system.\n - The following is a list of unowned files and/or directories:\n$(printf '%s\n' "${a_nouser[@]}")\n - end of list": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or directories on the system.\n - The following is a list of unowned files and/or directories:\n$(printf '%s\n' "${a_nouser[@]}")\n - end of list": ${l_result_17}"
   fi

   l_result_18="$(if ! (( ${#a_nogroup[@]} > 0 )); then 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - if ! (( ${#a_nogroup[@]} > 0 )); then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ! (( ${#a_nogroup[@]} > 0 )); then: ${l_result_18}"
   fi

   l_result_19="$(l_output="$l_output\n - No files or directories without a group exist on the local filesystem." 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - No files or directories without a group exist on the local filesystem.": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - No files or directories without a group exist on the local filesystem.": ${l_result_19}"
   fi

   l_result_20="$(else 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_20}"
   fi

   l_result_21="$(l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files or directories on the system.\n - The following is a list of ungrouped files and/or directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n - end of list" 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files or directories on the system.\n - The following is a list of ungrouped files and/or directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n - end of list": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files or directories on the system.\n - The following is a list of ungrouped files and/or directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n - end of list": ${l_result_21}"
   fi

   l_result_22="$(unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays: ${l_result_22}"
   fi

   l_result_23="$(if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass: ${l_result_23}"
   fi

   l_result_24="$(echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n": ${l_result_24}"
   fi

   l_result_25="$(else 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_25}"
   fi

   l_result_26="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": ${l_result_26}"
   fi

   l_result_27="$([ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n": ${l_result_27}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
