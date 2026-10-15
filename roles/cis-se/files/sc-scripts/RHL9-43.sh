#!/bin/bash
# RHL9-43 | Ensure message of the day is configured properly

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

   l_result_3="$(a_files=() 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - a_files=(): no output (PASS)"
   else
      l_output2="$l_output2\n - a_files=(): ${l_result_3}"
   fi

   l_result_4="$(for l_file in /etc/motd{,.d/*}; do 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - for l_file in /etc/motd{,.d/*}; do: no output (PASS)"
   else
      l_output2="$l_output2\n - for l_file in /etc/motd{,.d/*}; do: ${l_result_4}"
   fi

   l_result_5="$(if grep -Psqi -- "(\\\v|\\\r|\\\m|\\\s|\b$(grep ^ID= /etc/os-release | cut -d= -f2 | sed -e 's/"//g')\b)" "$l_file"; then 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - if grep -Psqi -- "(\\\v|\\\r|\\\m|\\\s|\b$(grep ^ID= /etc/os-release | cut -d= -f2 | sed -e 's/"//g')\b)" "$l_file"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Psqi -- "(\\\v|\\\r|\\\m|\\\s|\b$(grep ^ID= /etc/os-release | cut -d= -f2 | sed -e 's/"//g')\b)" "$l_file"; then: ${l_result_5}"
   fi

   l_result_6="$(l_output2="$l_output2\n - File: \"$l_file\" includes system information" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - File: \"$l_file\" includes system information": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - File: \"$l_file\" includes system information": ${l_result_6}"
   fi

   l_result_7="$(else 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_7}"
   fi

   l_result_8="$(a_files+=("$l_file") 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - a_files+=("$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_files+=("$l_file"): ${l_result_8}"
   fi

   l_result_9="$(done 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - done: no output (PASS)"
   else
      l_output2="$l_output2\n - done: ${l_result_9}"
   fi

   l_result_10="$(if [ "${#a_files[@]}" -gt 0 ]; then 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - if [ "${#a_files[@]}" -gt 0 ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "${#a_files[@]}" -gt 0 ]; then: ${l_result_10}"
   fi

   l_result_11="$(echo -e "\n- ** Please review the following files and verify their contents follow local site policy **\n" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - echo -e "\n- ** Please review the following files and verify their contents follow local site policy **\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- ** Please review the following files and verify their contents follow local site policy **\n": ${l_result_11}"
   fi

   l_result_12="$(printf '%s\n' "${a_files[@]}" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - printf '%s\n' "${a_files[@]}": no output (PASS)"
   else
      l_output2="$l_output2\n - printf '%s\n' "${a_files[@]}": ${l_result_12}"
   fi

   l_result_13="$(elif [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - elif [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif [ -z "$l_output2" ]; then: ${l_result_13}"
   fi

   l_result_14="$(echo -e "- ** No MOTD files with any size were found. Please verify this conforms to local site policy ** -" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - echo -e "- ** No MOTD files with any size were found. Please verify this conforms to local site policy ** -": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "- ** No MOTD files with any size were found. Please verify this conforms to local site policy ** -": ${l_result_14}"
   fi

   l_result_15="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_15}"
   fi

   l_result_16="$(l_output=" - No MOTD files include system information" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_output=" - No MOTD files include system information": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output=" - No MOTD files include system information": ${l_result_16}"
   fi

   l_result_17="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_17}"
   fi

   l_result_18="$(else 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_18}"
   fi

   l_result_19="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_19}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
