#!/bin/bash
# RHL9-96 | Ensure a single firewall configuration utility is in use

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" l_fwd_status="" l_nft_status="" l_fwutil_status="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="" l_fwd_status="" l_nft_status="" l_fwutil_status="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="" l_fwd_status="" l_nft_status="" l_fwutil_status="": ${l_result_2}"
   fi

   l_result_3="$(Determine FirewallD utility Status 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - Determine FirewallD utility Status: no output (PASS)"
   else
      l_output2="$l_output2\n - Determine FirewallD utility Status: ${l_result_3}"
   fi

   l_result_4="$(rpm -q firewalld > /dev/null 2>&1 && l_fwd_status="$(systemctl is-enabled firewalld.service):$(systemctl is-active firewalld.service)" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - rpm -q firewalld > /dev/null 2>&1 && l_fwd_status="$(systemctl is-enabled firewalld.service):$(systemctl is-active firewalld.service)": no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q firewalld > /dev/null 2>&1 && l_fwd_status="$(systemctl is-enabled firewalld.service):$(systemctl is-active firewalld.service)": ${l_result_4}"
   fi

   l_result_5="$(Determine NFTables utility Status 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - Determine NFTables utility Status: no output (PASS)"
   else
      l_output2="$l_output2\n - Determine NFTables utility Status: ${l_result_5}"
   fi

   l_result_6="$(rpm -q nftables > /dev/null 2>&1 && l_nft_status="$(systemctl is-enabled nftables.service):$(systemctl is-active nftables.service)" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - rpm -q nftables > /dev/null 2>&1 && l_nft_status="$(systemctl is-enabled nftables.service):$(systemctl is-active nftables.service)": no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q nftables > /dev/null 2>&1 && l_nft_status="$(systemctl is-enabled nftables.service):$(systemctl is-active nftables.service)": ${l_result_6}"
   fi

   l_result_7="$(l_fwutil_status="$l_fwd_status:$l_nft_status" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - l_fwutil_status="$l_fwd_status:$l_nft_status": no output (PASS)"
   else
      l_output2="$l_output2\n - l_fwutil_status="$l_fwd_status:$l_nft_status": ${l_result_7}"
   fi

   l_result_8="$(case $l_fwutil_status in 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - case $l_fwutil_status in: no output (PASS)"
   else
      l_output2="$l_output2\n - case $l_fwutil_status in: ${l_result_8}"
   fi

   l_result_9="$(enabled:active:masked:inactive|enabled:active:disabled:inactive) 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - enabled:active:masked:inactive|enabled:active:disabled:inactive): no output (PASS)"
   else
      l_output2="$l_output2\n - enabled:active:masked:inactive|enabled:active:disabled:inactive): ${l_result_9}"
   fi

   l_result_10="$(l_output="\n - FirewallD utility is in use, enabled and active\n - NFTables utility is correctly disabled or masked and inactive\n - Only configure the recommendations found in the Configure Firewalld subsection" ;; 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_output="\n - FirewallD utility is in use, enabled and active\n - NFTables utility is correctly disabled or masked and inactive\n - Only configure the recommendations found in the Configure Firewalld subsection" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="\n - FirewallD utility is in use, enabled and active\n - NFTables utility is correctly disabled or masked and inactive\n - Only configure the recommendations found in the Configure Firewalld subsection" ;;: ${l_result_10}"
   fi

   l_result_11="$(masked:inactive:enabled:active|disabled:inactive:enabled:active) 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - masked:inactive:enabled:active|disabled:inactive:enabled:active): no output (PASS)"
   else
      l_output2="$l_output2\n - masked:inactive:enabled:active|disabled:inactive:enabled:active): ${l_result_11}"
   fi

   l_result_12="$(l_output="\n - NFTables utility is in use, enabled and active\n - FirewallD utility is correctly disabled or masked and inactive\n - Only configure the recommendations found in the Configure NFTables subsection" ;; 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - l_output="\n - NFTables utility is in use, enabled and active\n - FirewallD utility is correctly disabled or masked and inactive\n - Only configure the recommendations found in the Configure NFTables subsection" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="\n - NFTables utility is in use, enabled and active\n - FirewallD utility is correctly disabled or masked and inactive\n - Only configure the recommendations found in the Configure NFTables subsection" ;;: ${l_result_12}"
   fi

   l_result_13="$(enabled:active:enabled:active) 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - enabled:active:enabled:active): no output (PASS)"
   else
      l_output2="$l_output2\n - enabled:active:enabled:active): ${l_result_13}"
   fi

   l_result_14="$(l_output2="\n - Both FirewallD and NFTables utilities are enabled and active. Configure only ONE firewall either NFTables OR Firewalld" ;; 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - l_output2="\n - Both FirewallD and NFTables utilities are enabled and active. Configure only ONE firewall either NFTables OR Firewalld" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="\n - Both FirewallD and NFTables utilities are enabled and active. Configure only ONE firewall either NFTables OR Firewalld" ;;: ${l_result_14}"
   fi

   l_result_15="$(enabled:*:enabled:*) 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - enabled:*:enabled:*): no output (PASS)"
   else
      l_output2="$l_output2\n - enabled:*:enabled:*): ${l_result_15}"
   fi

   l_result_16="$(l_output2="\n - Both FirewallD and NFTables utilities are enabled\n - Configure only ONE firewall: either NFTables OR Firewalld" ;; 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_output2="\n - Both FirewallD and NFTables utilities are enabled\n - Configure only ONE firewall: either NFTables OR Firewalld" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="\n - Both FirewallD and NFTables utilities are enabled\n - Configure only ONE firewall: either NFTables OR Firewalld" ;;: ${l_result_16}"
   fi

   l_result_17="$(*:active:*:active) 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - *:active:*:active): no output (PASS)"
   else
      l_output2="$l_output2\n - *:active:*:active): ${l_result_17}"
   fi

   l_result_18="$(l_output2="\n - Both FirewallD and NFTables utilities are enabled\n - Configure only ONE firewall: either NFTables OR Firewalld" ;; 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_output2="\n - Both FirewallD and NFTables utilities are enabled\n - Configure only ONE firewall: either NFTables OR Firewalld" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="\n - Both FirewallD and NFTables utilities are enabled\n - Configure only ONE firewall: either NFTables OR Firewalld" ;;: ${l_result_18}"
   fi

   l_result_19="$(:enabled:active) 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - :enabled:active): no output (PASS)"
   else
      l_output2="$l_output2\n - :enabled:active): ${l_result_19}"
   fi

   l_result_20="$(l_output="\n - NFTables utility is in use, enabled, and active\n - FirewallD package is not installed\n - Only configure the recommendations found in the Configure NFTables subsection" ;; 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - l_output="\n - NFTables utility is in use, enabled, and active\n - FirewallD package is not installed\n - Only configure the recommendations found in the Configure NFTables subsection" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="\n - NFTables utility is in use, enabled, and active\n - FirewallD package is not installed\n - Only configure the recommendations found in the Configure NFTables subsection" ;;: ${l_result_20}"
   fi

   l_result_21="$(l_output2="\n - Neither FirewallD or NFTables is installed. Configure only ONE firewall either NFTables OR Firewalld" ;; 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - l_output2="\n - Neither FirewallD or NFTables is installed. Configure only ONE firewall either NFTables OR Firewalld" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="\n - Neither FirewallD or NFTables is installed. Configure only ONE firewall either NFTables OR Firewalld" ;;: ${l_result_21}"
   fi

   l_result_22="$(*:*:) 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - *:*:): no output (PASS)"
   else
      l_output2="$l_output2\n - *:*:): ${l_result_22}"
   fi

   l_result_23="$(l_output2="\n - NFTables package is not installed on the system. Install NFTables and Configure only ONE firewall either NFTables OR Firewalld" ;; 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - l_output2="\n - NFTables package is not installed on the system. Install NFTables and Configure only ONE firewall either NFTables OR Firewalld" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="\n - NFTables package is not installed on the system. Install NFTables and Configure only ONE firewall either NFTables OR Firewalld" ;;: ${l_result_23}"
   fi

   l_result_24="$(l_output2="\n - Unable to determine firewall state. Configure only ONE firewall either NFTables OR Firewalld" ;; 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_output2="\n - Unable to determine firewall state. Configure only ONE firewall either NFTables OR Firewalld" ;;: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="\n - Unable to determine firewall state. Configure only ONE firewall either NFTables OR Firewalld" ;;: ${l_result_24}"
   fi

   l_result_25="$(esac 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - esac: no output (PASS)"
   else
      l_output2="$l_output2\n - esac: ${l_result_25}"
   fi

   l_result_26="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_26}"
   fi

   l_result_27="$(echo -e "\n- Audit Results:\n ** Pass **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Results:\n ** Pass **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Results:\n ** Pass **\n$l_output\n": ${l_result_27}"
   fi

   l_result_28="$(else 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_28}"
   fi

   l_result_29="$(echo -e "\n- Audit Results:\n ** Fail **\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Results:\n ** Fail **\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Results:\n ** Fail **\n$l_output2\n": ${l_result_29}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
