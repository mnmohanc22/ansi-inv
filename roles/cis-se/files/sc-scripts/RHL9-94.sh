#!/bin/bash
# RHL9-94 | Ensure ipv6 router advertisements are not accepted

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" l_ipv6_disabled="" # Clear output variables 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="" l_ipv6_disabled="" # Clear output variables: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="" l_ipv6_disabled="" # Clear output variables: ${l_result_2}"
   fi

   l_result_3="$(a_parlist=("net.ipv6.conf.all.accept_ra=0" "net.ipv6.conf.default.accept_ra=0") 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - a_parlist=("net.ipv6.conf.all.accept_ra=0" "net.ipv6.conf.default.accept_ra=0"): no output (PASS)"
   else
      l_output2="$l_output2\n - a_parlist=("net.ipv6.conf.all.accept_ra=0" "net.ipv6.conf.default.accept_ra=0"): ${l_result_3}"
   fi

   l_result_4="$(l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)": ${l_result_4}"
   fi

   l_result_5="$(f_ipv6_chk() 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - f_ipv6_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - f_ipv6_chk(): ${l_result_5}"
   fi

   l_result_6="$(l_ipv6_disabled="" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_ipv6_disabled="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ipv6_disabled="": ${l_result_6}"
   fi

   l_result_7="$(! grep -Pqs -- '^\h*0\b' /sys/module/ipv6/parameters/disable && l_ipv6_disabled="yes" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - ! grep -Pqs -- '^\h*0\b' /sys/module/ipv6/parameters/disable && l_ipv6_disabled="yes": no output (PASS)"
   else
      l_output2="$l_output2\n - ! grep -Pqs -- '^\h*0\b' /sys/module/ipv6/parameters/disable && l_ipv6_disabled="yes": ${l_result_7}"
   fi

   l_result_8="$(if sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\b" && \ 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - if sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\b" && \: no output (PASS)"
   else
      l_output2="$l_output2\n - if sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\b" && \: ${l_result_8}"
   fi

   l_result_9="$(sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\b"; then 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\b"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\b"; then: ${l_result_9}"
   fi

   l_result_10="$(l_ipv6_disabled="yes" 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_ipv6_disabled="yes": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ipv6_disabled="yes": ${l_result_10}"
   fi

   l_result_11="$([ -z "$l_ipv6_disabled" ] && l_ipv6_disabled="no" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - [ -z "$l_ipv6_disabled" ] && l_ipv6_disabled="no": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_ipv6_disabled" ] && l_ipv6_disabled="no": ${l_result_11}"
   fi

   l_result_12="$(f_kernel_parameter_chk() 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - f_kernel_parameter_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - f_kernel_parameter_chk(): ${l_result_12}"
   fi

   l_result_13="$(l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)": ${l_result_13}"
   fi

   l_result_14="$(if [ "$l_krp" = "$l_kpvalue" ]; then 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - if [ "$l_krp" = "$l_kpvalue" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_krp" = "$l_kpvalue" ]; then: ${l_result_14}"
   fi

   l_result_15="$(l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration" 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration": ${l_result_15}"
   fi

   l_result_16="$(else 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_16}"
   fi

   l_result_17="$(l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\"" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\"": ${l_result_17}"
   fi

   l_result_18="$(unset A_out; declare -A A_out # Check durable setting (files) 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - unset A_out; declare -A A_out # Check durable setting (files): no output (PASS)"
   else
      l_output2="$l_output2\n - unset A_out; declare -A A_out # Check durable setting (files): ${l_result_18}"
   fi

   l_result_19="$(while read -r l_out; do 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - while read -r l_out; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while read -r l_out; do: ${l_result_19}"
   fi

   l_result_20="$(if [ -n "$l_out" ]; then 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - if [ -n "$l_out" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_out" ]; then: ${l_result_20}"
   fi

   l_result_21="$(if [[ $l_out =~ ^\s*# ]]; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if [[ $l_out =~ ^\s*# ]]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [[ $l_out =~ ^\s*# ]]; then: ${l_result_21}"
   fi

   l_result_22="$(l_file="${l_out//# /}" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_file="${l_out//# /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_file="${l_out//# /}": ${l_result_22}"
   fi

   l_result_23="$(else 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_23}"
   fi

   l_result_24="$(l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)": ${l_result_24}"
   fi

   l_result_25="$([ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file") 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file"): no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file"): ${l_result_25}"
   fi

   l_result_26="$(done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)') 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)'): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)'): ${l_result_26}"
   fi

   l_result_27="$(if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config) 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config): no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config): ${l_result_27}"
   fi

   l_result_28="$(l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)": ${l_result_28}"
   fi

   l_result_29="$(l_kpar="${l_kpar//\//.}" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - l_kpar="${l_kpar//\//.}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_kpar="${l_kpar//\//.}": ${l_result_29}"
   fi

   l_result_30="$([ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf") 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf"): no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf"): ${l_result_30}"
   fi

   l_result_31="$(if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output: no output (PASS)"
   else
      l_output2="$l_output2\n - if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output: ${l_result_31}"
   fi

   l_result_32="$(while IFS="=" read -r l_fkpname l_fkpvalue; do 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - while IFS="=" read -r l_fkpname l_fkpvalue; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS="=" read -r l_fkpname l_fkpvalue; do: ${l_result_32}"
   fi

   l_result_33="$(l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}" 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}": ${l_result_33}"
   fi

   l_result_34="$(if [ "$l_fkpvalue" = "$l_kpvalue" ]; then 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - if [ "$l_fkpvalue" = "$l_kpvalue" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_fkpvalue" = "$l_kpvalue" ]; then: ${l_result_34}"
   fi

   l_result_35="$(l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n" 2>/dev/null)"
   if [ -z "${l_result_35}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n": ${l_result_35}"
   fi

   l_result_36="$(else 2>/dev/null)"
   if [ -z "${l_result_36}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_36}"
   fi

   l_result_37="$(l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n" 2>/dev/null)"
   if [ -z "${l_result_37}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n": ${l_result_37}"
   fi

   l_result_38="$(done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}") 2>/dev/null)"
   if [ -z "${l_result_38}" ]; then
      l_output="$l_output\n - done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}"): ${l_result_38}"
   fi

   l_result_39="$(else 2>/dev/null)"
   if [ -z "${l_result_39}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_39}"
   fi

   l_result_40="$(l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n" 2>/dev/null)"
   if [ -z "${l_result_40}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n": ${l_result_40}"
   fi

   l_result_41="$(while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters 2>/dev/null)"
   if [ -z "${l_result_41}" ]; then
      l_output="$l_output\n - while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters: ${l_result_41}"
   fi

   l_result_42="$(l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}" 2>/dev/null)"
   if [ -z "${l_result_42}" ]; then
      l_output="$l_output\n - l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}": no output (PASS)"
   else
      l_output2="$l_output2\n - l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}": ${l_result_42}"
   fi

   l_result_43="$(if grep -q '^net.ipv6.' <<< "$l_kpname"; then 2>/dev/null)"
   if [ -z "${l_result_43}" ]; then
      l_output="$l_output\n - if grep -q '^net.ipv6.' <<< "$l_kpname"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -q '^net.ipv6.' <<< "$l_kpname"; then: ${l_result_43}"
   fi

   l_result_44="$([ -z "$l_ipv6_disabled" ] && f_ipv6_chk 2>/dev/null)"
   if [ -z "${l_result_44}" ]; then
      l_output="$l_output\n - [ -z "$l_ipv6_disabled" ] && f_ipv6_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_ipv6_disabled" ] && f_ipv6_chk: ${l_result_44}"
   fi

   l_result_45="$(if [ "$l_ipv6_disabled" = "yes" ]; then 2>/dev/null)"
   if [ -z "${l_result_45}" ]; then
      l_output="$l_output\n - if [ "$l_ipv6_disabled" = "yes" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_ipv6_disabled" = "yes" ]; then: ${l_result_45}"
   fi

   l_result_46="$(l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable" 2>/dev/null)"
   if [ -z "${l_result_46}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable": ${l_result_46}"
   fi

   l_result_47="$(else 2>/dev/null)"
   if [ -z "${l_result_47}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_47}"
   fi

   l_result_48="$(f_kernel_parameter_chk 2>/dev/null)"
   if [ -z "${l_result_48}" ]; then
      l_output="$l_output\n - f_kernel_parameter_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - f_kernel_parameter_chk: ${l_result_48}"
   fi

   l_result_49="$(else 2>/dev/null)"
   if [ -z "${l_result_49}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_49}"
   fi

   l_result_50="$(f_kernel_parameter_chk 2>/dev/null)"
   if [ -z "${l_result_50}" ]; then
      l_output="$l_output\n - f_kernel_parameter_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - f_kernel_parameter_chk: ${l_result_50}"
   fi

   l_result_51="$(done < <(printf '%s\n' "${a_parlist[@]}") 2>/dev/null)"
   if [ -z "${l_result_51}" ]; then
      l_output="$l_output\n - done < <(printf '%s\n' "${a_parlist[@]}"): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(printf '%s\n' "${a_parlist[@]}"): ${l_result_51}"
   fi

   l_result_52="$(l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)" 2>/dev/null)"
   if [ -z "${l_result_52}" ]; then
      l_output="$l_output\n - l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)": ${l_result_52}"
   fi

   l_result_53="$(unset a_parlist; unset A_out # unset arrays 2>/dev/null)"
   if [ -z "${l_result_53}" ]; then
      l_output="$l_output\n - unset a_parlist; unset A_out # unset arrays: no output (PASS)"
   else
      l_output2="$l_output2\n - unset a_parlist; unset A_out # unset arrays: ${l_result_53}"
   fi

   l_result_54="$(if [ -z "$l_output2" ]; then # Provide output from checks 2>/dev/null)"
   if [ -z "${l_result_54}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then # Provide output from checks: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then # Provide output from checks: ${l_result_54}"
   fi

   l_result_55="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_55}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_55}"
   fi

   l_result_56="$(else 2>/dev/null)"
   if [ -z "${l_result_56}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_56}"
   fi

   l_result_57="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_57}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_57}"
   fi

   l_result_58="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_58}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_58}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
