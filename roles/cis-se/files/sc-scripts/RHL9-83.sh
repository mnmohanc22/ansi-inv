#!/bin/bash
# RHL9-83 | Ensure wireless interfaces are disabled

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

   l_result_3="$(module_chk() 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - module_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - module_chk(): ${l_result_3}"
   fi

   l_result_4="$(Check how module will be loaded 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Check how module will be loaded: no output (PASS)"
   else
      l_output2="$l_output2\n - Check how module will be loaded: ${l_result_4}"
   fi

   l_result_5="$(l_loadable="$(modprobe -n -v "$l_mname")" 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - l_loadable="$(modprobe -n -v "$l_mname")": no output (PASS)"
   else
      l_output2="$l_output2\n - l_loadable="$(modprobe -n -v "$l_mname")": ${l_result_5}"
   fi

   l_result_6="$(if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then: ${l_result_6}"
   fi

   l_result_7="$(l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\"" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\"": ${l_result_7}"
   fi

   l_result_8="$(else 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_8}"
   fi

   l_result_9="$(l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\"" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\"": ${l_result_9}"
   fi

   l_result_10="$(Check is the module currently loaded 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - Check is the module currently loaded: no output (PASS)"
   else
      l_output2="$l_output2\n - Check is the module currently loaded: ${l_result_10}"
   fi

   l_result_11="$(if ! lsmod | grep "$l_mname" > /dev/null 2> then 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - if ! lsmod | grep "$l_mname" > /dev/null 2> then: no output (PASS)"
   else
      l_output2="$l_output2\n - if ! lsmod | grep "$l_mname" > /dev/null 2> then: ${l_result_11}"
   fi

   l_result_12="$(l_output="$l_output\n - module: \"$l_mname\" is not loaded" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - module: \"$l_mname\" is not loaded": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - module: \"$l_mname\" is not loaded": ${l_result_12}"
   fi

   l_result_13="$(else 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_13}"
   fi

   l_result_14="$(l_output2="$l_output2\n - module: \"$l_mname\" is loaded" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - module: \"$l_mname\" is loaded": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - module: \"$l_mname\" is loaded": ${l_result_14}"
   fi

   l_result_15="$(Check if the module is deny listed 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - Check if the module is deny listed: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if the module is deny listed: ${l_result_15}"
   fi

   l_result_16="$(if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mname\b"; then 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mname\b"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mname\b"; then: ${l_result_16}"
   fi

   l_result_17="$(l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pl -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*)\"" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pl -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*)\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pl -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*)\"": ${l_result_17}"
   fi

   l_result_18="$(else 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_18}"
   fi

   l_result_19="$(l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed" 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed": ${l_result_19}"
   fi

   l_result_20="$(if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then: ${l_result_20}"
   fi

   l_result_21="$(l_dname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u) 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - l_dname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u): no output (PASS)"
   else
      l_output2="$l_output2\n - l_dname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u): ${l_result_21}"
   fi

   l_result_22="$(for l_mname in $l_dname; do 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - for l_mname in $l_dname; do: no output (PASS)"
   else
      l_output2="$l_output2\n - for l_mname in $l_dname; do: ${l_result_22}"
   fi

   l_result_23="$(module_chk 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - module_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - module_chk: ${l_result_23}"
   fi

   l_result_24="$(done 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - done: no output (PASS)"
   else
      l_output2="$l_output2\n - done: ${l_result_24}"
   fi

   l_result_25="$(Report results. If no failures output in l_output2, we pass 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - Report results. If no failures output in l_output2, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - Report results. If no failures output in l_output2, we pass: ${l_result_25}"
   fi

   l_result_26="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_26}"
   fi

   l_result_27="$(echo -e "\n- Audit Result:\n ** PASS **" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **": ${l_result_27}"
   fi

   l_result_28="$(if [ -z "$l_output" ]; then 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - if [ -z "$l_output" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output" ]; then: ${l_result_28}"
   fi

   l_result_29="$(echo -e "\n - System has no wireless NICs installed" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - echo -e "\n - System has no wireless NICs installed": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n - System has no wireless NICs installed": ${l_result_29}"
   fi

   l_result_30="$(else 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_30}"
   fi

   l_result_31="$(echo -e "\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - echo -e "\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n$l_output\n": ${l_result_31}"
   fi

   l_result_32="$(else 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_32}"
   fi

   l_result_33="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_33}"
   fi

   l_result_34="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_34}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
