#!/bin/bash
# RHL9-213 | Ensure system wide crypto policy disables cbc for ssh

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

   l_result_3="$(if grep -Piq -- '^\h*cipher\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - if grep -Piq -- '^\h*cipher\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Piq -- '^\h*cipher\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then: ${l_result_3}"
   fi

   l_result_4="$(if grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*' /etc/crypto-policies/state/CURRENT.pol; then 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - if grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*' /etc/crypto-policies/state/CURRENT.pol; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*' /etc/crypto-policies/state/CURRENT.pol; then: ${l_result_4}"
   fi

   l_result_5="$(if ! grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - if ! grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ! grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then: ${l_result_5}"
   fi

   l_result_6="$(l_output="$l_output\n - Cipher Block Chaining (CBC) is disabled for SSH" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - Cipher Block Chaining (CBC) is disabled for SSH": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - Cipher Block Chaining (CBC) is disabled for SSH": ${l_result_6}"
   fi

   l_result_7="$(else 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_7}"
   fi

   l_result_8="$(l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH": ${l_result_8}"
   fi

   l_result_9="$(else 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_9}"
   fi

   l_result_10="$(l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH" 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for SSH": ${l_result_10}"
   fi

   l_result_11="$(else 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_11}"
   fi

   l_result_12="$(l_output=" - Cipher Block Chaining (CBC) is disabled" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_output=" - Cipher Block Chaining (CBC) is disabled": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output=" - Cipher Block Chaining (CBC) is disabled": ${l_result_12}"
   fi

   l_result_13="$(if [ -z "$l_output2" ]; then # Provide output from checks 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then # Provide output from checks: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then # Provide output from checks: ${l_result_13}"
   fi

   l_result_14="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_14}"
   fi

   l_result_15="$(else 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_15}"
   fi

   l_result_16="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_16}"
   fi

   l_result_17="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_17}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
