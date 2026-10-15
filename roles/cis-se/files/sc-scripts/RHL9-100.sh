#!/bin/bash
# RHL9-100 | Ensure firewalld loopback traffic is configured

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" l_hbfw="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="" l_hbfw="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="" l_hbfw="": ${l_result_2}"
   fi

   l_result_3="$(if systemctl is-enabled firewalld.service | grep -q 'enabled'; then 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - if systemctl is-enabled firewalld.service | grep -q 'enabled'; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if systemctl is-enabled firewalld.service | grep -q 'enabled'; then: ${l_result_3}"
   fi

   l_result_4="$(echo -e "\n - FirewallD is in use on the system" && l_hbfw="fwd" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - echo -e "\n - FirewallD is in use on the system" && l_hbfw="fwd": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n - FirewallD is in use on the system" && l_hbfw="fwd": ${l_result_4}"
   fi

   l_result_5="$(elif systemctl is-enabled nftables.service 2>/dev/null | grep -q 'enabled'; then 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - elif systemctl is-enabled nftables.service 2>/dev/null | grep -q 'enabled'; then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif systemctl is-enabled nftables.service 2>/dev/null | grep -q 'enabled'; then: ${l_result_5}"
   fi

   l_result_6="$(echo -e "\n - nftables is in use on the system \n - Recommendation is NA" && l_hbfw="nft" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - echo -e "\n - nftables is in use on the system \n - Recommendation is NA" && l_hbfw="nft": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n - nftables is in use on the system \n - Recommendation is NA" && l_hbfw="nft": ${l_result_6}"
   fi

   l_result_7="$(else 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_7}"
   fi

   l_result_8="$(echo -e "\n - Error - Neither FirewallD or NFTables is enabled\n - Please follow recommendation: \"Ensure a single firewall configuration utility is in use\"" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - echo -e "\n - Error - Neither FirewallD or NFTables is enabled\n - Please follow recommendation: \"Ensure a single firewall configuration utility is in use\"": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n - Error - Neither FirewallD or NFTables is enabled\n - Please follow recommendation: \"Ensure a single firewall configuration utility is in use\"": ${l_result_8}"
   fi

   l_result_9="$(if [ "$l_hbfw" = "fwd" ]; then 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - if [ "$l_hbfw" = "fwd" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_hbfw" = "fwd" ]; then: ${l_result_9}"
   fi

   l_result_10="$(if nft list ruleset | awk '/hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -Pq -- '\H+\h+"lo"\h+accept'; then 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - if nft list ruleset | awk '/hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -Pq -- '\H+\h+"lo"\h+accept'; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if nft list ruleset | awk '/hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -Pq -- '\H+\h+"lo"\h+accept'; then: ${l_result_10}"
   fi

   l_result_11="$(l_output="$l_output\n - Network traffic to the loopback address is correctly set to accept" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - Network traffic to the loopback address is correctly set to accept": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - Network traffic to the loopback address is correctly set to accept": ${l_result_11}"
   fi

   l_result_12="$(else 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_12}"
   fi

   l_result_13="$(l_output2="$l_output2\n - Network traffic to the loopback address is not set to accept" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - Network traffic to the loopback address is not set to accept": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - Network traffic to the loopback address is not set to accept": ${l_result_13}"
   fi

   l_result_14="$(l_ipsaddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -P -- 'ip\h+saddr')" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - l_ipsaddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -P -- 'ip\h+saddr')": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ipsaddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -P -- 'ip\h+saddr')": ${l_result_14}"
   fi

   l_result_15="$(if grep -Pq -- 'ip\h+saddr\h+127\.0\.0\.0\/8\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ipsaddr" || grep -Pq -- 'ip\h+daddr\h+\!\=\h+127\.0\.0\.1\h+ip\h+saddr\h+127\.0\.0\.1\h+drop' <<< "$l_ipsaddr"; then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if grep -Pq -- 'ip\h+saddr\h+127\.0\.0\.0\/8\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ipsaddr" || grep -Pq -- 'ip\h+daddr\h+\!\=\h+127\.0\.0\.1\h+ip\h+saddr\h+127\.0\.0\.1\h+drop' <<< "$l_ipsaddr"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pq -- 'ip\h+saddr\h+127\.0\.0\.0\/8\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ipsaddr" || grep -Pq -- 'ip\h+daddr\h+\!\=\h+127\.0\.0\.1\h+ip\h+saddr\h+127\.0\.0\.1\h+drop' <<< "$l_ipsaddr"; then: ${l_result_15}"
   fi

   l_result_16="$(l_output="$l_output\n - IPv4 network traffic from loopback address correctly set to drop" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - IPv4 network traffic from loopback address correctly set to drop": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - IPv4 network traffic from loopback address correctly set to drop": ${l_result_16}"
   fi

   l_result_17="$(else 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_17}"
   fi

   l_result_18="$(l_output2="$l_output2\n - IPv4 network traffic from loopback address not set to drop" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - IPv4 network traffic from loopback address not set to drop": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - IPv4 network traffic from loopback address not set to drop": ${l_result_18}"
   fi

   l_result_19="$(if grep -Pq -- '^\h*0\h*$' /sys/module/ipv6/parameters/disable; then 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - if grep -Pq -- '^\h*0\h*$' /sys/module/ipv6/parameters/disable; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pq -- '^\h*0\h*$' /sys/module/ipv6/parameters/disable; then: ${l_result_19}"
   fi

   l_result_20="$(l_ip6saddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook input/,/}/' | grep 'ip6 saddr')" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - l_ip6saddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook input/,/}/' | grep 'ip6 saddr')": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ip6saddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook input/,/}/' | grep 'ip6 saddr')": ${l_result_20}"
   fi

   l_result_21="$(if grep -Pq 'ip6\h+saddr\h+::1\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ip6saddr" || grep -Pq -- 'ip6\h+daddr\h+\!=\h+::1\h+ip6\h+saddr\h+::1\h+drop' <<< "$l_ip6saddr"; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if grep -Pq 'ip6\h+saddr\h+::1\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ip6saddr" || grep -Pq -- 'ip6\h+daddr\h+\!=\h+::1\h+ip6\h+saddr\h+::1\h+drop' <<< "$l_ip6saddr"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pq 'ip6\h+saddr\h+::1\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ip6saddr" || grep -Pq -- 'ip6\h+daddr\h+\!=\h+::1\h+ip6\h+saddr\h+::1\h+drop' <<< "$l_ip6saddr"; then: ${l_result_21}"
   fi

   l_result_22="$(l_output="$l_output\n - IPv6 network traffic from loopback address correctly set to drop" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - IPv6 network traffic from loopback address correctly set to drop": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - IPv6 network traffic from loopback address correctly set to drop": ${l_result_22}"
   fi

   l_result_23="$(else 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_23}"
   fi

   l_result_24="$(l_output2="$l_output2\n - IPv6 network traffic from loopback address not set to drop" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - IPv6 network traffic from loopback address not set to drop": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - IPv6 network traffic from loopback address not set to drop": ${l_result_24}"
   fi

   l_result_25="$(if [ "$l_hbfw" = "nft" ] || [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - if [ "$l_hbfw" = "nft" ] || [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ "$l_hbfw" = "nft" ] || [ -z "$l_output2" ]; then: ${l_result_25}"
   fi

   l_result_26="$(echo -e "\n- Audit Result:\n *** PASS ***\n$l_output" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n *** PASS ***\n$l_output": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n *** PASS ***\n$l_output": ${l_result_26}"
   fi

   l_result_27="$(else 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_27}"
   fi

   l_result_28="$(echo -e "\n- Audit Result:\n *** FAIL ***\n$l_output2\n\n - Correctly set:\n$l_output" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n *** FAIL ***\n$l_output2\n\n - Correctly set:\n$l_output": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n *** FAIL ***\n$l_output2\n\n - Correctly set:\n$l_output": ${l_result_28}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
