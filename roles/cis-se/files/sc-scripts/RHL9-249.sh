#!/bin/bash
# RHL9-249 | Ensure accounts without a valid login shell are locked

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$": no output (PASS)"
   else
      l_output2="$l_output2\n - l_valid_shells="^($(awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$": ${l_result_2}"
   fi

   l_result_3="$(while IFS= read -r l_user; do 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - while IFS= read -r l_user; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r l_user; do: ${l_result_3}"
   fi

   l_result_4="$(passwd -S "$l_user" | awk '$2 !~ /^L/ {print "Account: \"" $1 "\" does not have a valid login shell and is not locked"}' 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - passwd -S "$l_user" | awk '$2 !~ /^L/ {print "Account: \"" $1 "\" does not have a valid login shell and is not locked"}': no output (PASS)"
   else
      l_output2="$l_output2\n - passwd -S "$l_user" | awk '$2 !~ /^L/ {print "Account: \"" $1 "\" does not have a valid login shell and is not locked"}': ${l_result_4}"
   fi

   l_result_5="$(done < <(awk -v pat="$l_valid_shells" -F: '($1 != "root" && $(NF) !~ pat) {print $1}' /etc/passwd) 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - done < <(awk -v pat="$l_valid_shells" -F: '($1 != "root" && $(NF) !~ pat) {print $1}' /etc/passwd): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(awk -v pat="$l_valid_shells" -F: '($1 != "root" && $(NF) !~ pat) {print $1}' /etc/passwd): ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
