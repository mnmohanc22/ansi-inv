#!/bin/bash
# RHL9-31 | Ensure bootloader password is set

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_grub_password_file="$(find /boot -type f -name 'user.cfg' ! -empty)" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_grub_password_file="$(find /boot -type f -name 'user.cfg' ! -empty)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_grub_password_file="$(find /boot -type f -name 'user.cfg' ! -empty)": ${l_result_2}"
   fi

   l_result_3="$(if [ -f "$l_grub_password_file" ]; then 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - if [ -f "$l_grub_password_file" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -f "$l_grub_password_file" ]; then: ${l_result_3}"
   fi

   l_result_4="$(awk -F. '/^\s*GRUB2_PASSWORD=\S+/ {print $1"."$2"."$3}' "$l_grub_password_file" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - awk -F. '/^\s*GRUB2_PASSWORD=\S+/ {print $1"."$2"."$3}' "$l_grub_password_file": no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F. '/^\s*GRUB2_PASSWORD=\S+/ {print $1"."$2"."$3}' "$l_grub_password_file": ${l_result_4}"
   fi

   l_result_5="$(GRUB2_PASSWORD=grub.pbkdf2.sha512 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - GRUB2_PASSWORD=grub.pbkdf2.sha512: no output (PASS)"
   else
      l_output2="$l_output2\n - GRUB2_PASSWORD=grub.pbkdf2.sha512: ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
