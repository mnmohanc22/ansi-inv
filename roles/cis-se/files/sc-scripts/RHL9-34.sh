#!/bin/bash
# RHL9-34 | Ensure core dump backtraces are disabled

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

   l_result_3="$(a_parlist=("ProcessSizeMax=0") 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - a_parlist=("ProcessSizeMax=0"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_parlist=("ProcessSizeMax=0"): ${l_result_3}"
   fi

   l_result_4="$(l_systemd_config_file="/etc/systemd/coredump.conf" # Main systemd configuration file 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_systemd_config_file="/etc/systemd/coredump.conf" # Main systemd configuration file: no output (PASS)"
   else
      l_output2="$l_output2\n - l_systemd_config_file="/etc/systemd/coredump.conf" # Main systemd configuration file: ${l_result_4}"
   fi

   l_result_5="$(config_file_parameter_chk() 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - config_file_parameter_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - config_file_parameter_chk(): ${l_result_5}"
   fi

   l_result_6="$(unset A_out; declare -A A_out # Check config file(s) setting 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - unset A_out; declare -A A_out # Check config file(s) setting: no output (PASS)"
   else
      l_output2="$l_output2\n - unset A_out; declare -A A_out # Check config file(s) setting: ${l_result_6}"
   fi

   l_result_7="$(while read -r l_out; do 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - while read -r l_out; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_out; do: ${l_result_7}"
   fi

   l_result_8="$(if [ -n "$l_out" ]; then 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - if [ -n "$l_out" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_out" ]; then: ${l_result_8}"
   fi

   l_result_9="$(if [[ $l_out =~ ^\s*# ]]; then 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - if [[ $l_out =~ ^\s*# ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ $l_out =~ ^\s*# ]]; then: ${l_result_9}"
   fi

   l_result_10="$(l_file="${l_out//# /}" 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_file="${l_out//# /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_file="${l_out//# /}": ${l_result_10}"
   fi

   l_result_11="$(else 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_11}"
   fi

   l_result_12="$(l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)": ${l_result_12}"
   fi

   l_result_13="$(grep -Piq -- "^\h*$l_systemd_parameter_name\b" <<< "$l_systemd_parameter" && A_out+=(["$l_systemd_parameter"]="$l_file") 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - grep -Piq -- "^\h*$l_systemd_parameter_name\b" <<< "$l_systemd_parameter" && A_out+=(["$l_systemd_parameter"]="$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Piq -- "^\h*$l_systemd_parameter_name\b" <<< "$l_systemd_parameter" && A_out+=(["$l_systemd_parameter"]="$l_file"): ${l_result_13}"
   fi

   l_result_14="$(done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)') 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)'): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)'): ${l_result_14}"
   fi

   l_result_15="$(if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output: no output (PASS)"
   else
      l_output2="$l_output2\n - if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output: ${l_result_15}"
   fi

   l_result_16="$(while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do: ${l_result_16}"
   fi

   l_result_17="$(l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}": ${l_result_17}"
   fi

   l_result_18="$(l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}": ${l_result_18}"
   fi

   l_result_19="$(if grep -Piq "^\h*$l_systemd_parameter_value\b" <<< "$l_systemd_file_parameter_value"; then 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - if grep -Piq "^\h*$l_systemd_parameter_value\b" <<< "$l_systemd_file_parameter_value"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Piq "^\h*$l_systemd_parameter_value\b" <<< "$l_systemd_file_parameter_value"; then: ${l_result_19}"
   fi

   l_result_20="$(l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n": ${l_result_20}"
   fi

   l_result_21="$(else 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_21}"
   fi

   l_result_22="$(l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value matching: \"$l_systemd_parameter_value\"\n" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value matching: \"$l_systemd_parameter_value\"\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to \"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value matching: \"$l_systemd_parameter_value\"\n": ${l_result_22}"
   fi

   l_result_23="$(done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}") 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}"): ${l_result_23}"
   fi

   l_result_24="$(else 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_24}"
   fi

   l_result_25="$(l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n ** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure **\n" 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n ** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure **\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n ** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure **\n": ${l_result_25}"
   fi

   l_result_26="$(while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do # Assess and check parameters 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do # Assess and check parameters: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do # Assess and check parameters: ${l_result_26}"
   fi

   l_result_27="$(l_systemd_parameter_name="${l_systemd_parameter_name// /}" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - l_systemd_parameter_name="${l_systemd_parameter_name// /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_systemd_parameter_name="${l_systemd_parameter_name// /}": ${l_result_27}"
   fi

   l_result_28="$(l_systemd_parameter_value="${l_systemd_parameter_value// /}" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - l_systemd_parameter_value="${l_systemd_parameter_value// /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_systemd_parameter_value="${l_systemd_parameter_value// /}": ${l_result_28}"
   fi

   l_result_29="$(config_file_parameter_chk 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - config_file_parameter_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - config_file_parameter_chk: ${l_result_29}"
   fi

   l_result_30="$(done < <(printf '%s\n' "${a_parlist[@]}") 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - done < <(printf '%s\n' "${a_parlist[@]}"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(printf '%s\n' "${a_parlist[@]}"): ${l_result_30}"
   fi

   l_result_31="$(if [ -z "$l_output2" ]; then # Provide output from checks 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then # Provide output from checks: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then # Provide output from checks: ${l_result_31}"
   fi

   l_result_32="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_32}"
   fi

   l_result_33="$(else 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_33}"
   fi

   l_result_34="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2": ${l_result_34}"
   fi

   l_result_35="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_35}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_35}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
