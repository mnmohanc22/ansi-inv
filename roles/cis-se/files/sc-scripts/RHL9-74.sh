#!/bin/bash
# RHL9-74 | Ensure mail transfer agents are configured for local-only mode

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

   l_result_3="$(a_port_list=("25" "465" "587") 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - a_port_list=("25" "465" "587"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_port_list=("25" "465" "587"): ${l_result_3}"
   fi

   l_result_4="$(if [ "$(postconf -n inet_interfaces)" != "inet_interfaces = all" ]; then 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - if [ "$(postconf -n inet_interfaces)" != "inet_interfaces = all" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$(postconf -n inet_interfaces)" != "inet_interfaces = all" ]; then: ${l_result_4}"
   fi

   l_result_5="$(for l_port_number in "${a_port_list[@]}"; do 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - for l_port_number in "${a_port_list[@]}"; do: no output (PASS)"
   else
      l_output2="$l_output2\n - for l_port_number in "${a_port_list[@]}"; do: ${l_result_5}"
   fi

   l_result_6="$(if ss -plntu | grep -P -- ':'"$l_port_number"'\b' | grep -Pvq -- '\h+(127\.0\.0\.1|\[?::1\]?):'"$l_port_number"'\b'; then 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - if ss -plntu | grep -P -- ':'"$l_port_number"'\b' | grep -Pvq -- '\h+(127\.0\.0\.1|\[?::1\]?):'"$l_port_number"'\b'; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ss -plntu | grep -P -- ':'"$l_port_number"'\b' | grep -Pvq -- '\h+(127\.0\.0\.1|\[?::1\]?):'"$l_port_number"'\b'; then: ${l_result_6}"
   fi

   l_result_7="$(l_output2="$l_output2\n - Port \"$l_port_number\" is listening on a non-loopback network interface" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - Port \"$l_port_number\" is listening on a non-loopback network interface": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - Port \"$l_port_number\" is listening on a non-loopback network interface": ${l_result_7}"
   fi

   l_result_8="$(else 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_8}"
   fi

   l_result_9="$(l_output="$l_output\n - Port \"$l_port_number\" is not listening on a non-loopback network interface" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - Port \"$l_port_number\" is not listening on a non-loopback network interface": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - Port \"$l_port_number\" is not listening on a non-loopback network interface": ${l_result_9}"
   fi

   l_result_10="$(done 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - done: no output (PASS)"
   else
      l_output2="$l_output2\n - done: ${l_result_10}"
   fi

   l_result_11="$(else 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_11}"
   fi

   l_result_12="$(l_output2="$l_output2\n - Postfix is bound to all interfaces" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - Postfix is bound to all interfaces": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - Postfix is bound to all interfaces": ${l_result_12}"
   fi

   l_result_13="$(unset a_port_list 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - unset a_port_list: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_port_list: ${l_result_13}"
   fi

   l_result_14="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_14}"
   fi

   l_result_15="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_15}"
   fi

   l_result_16="$(else 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_16}"
   fi

   l_result_17="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_17}"
   fi

   l_result_18="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_18}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
