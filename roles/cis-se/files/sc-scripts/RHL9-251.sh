#!/bin/bash
# RHL9-251 | Ensure only one logging system is in use

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" # Check the status of rsyslog and journald 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="" # Check the status of rsyslog and journald: no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="" # Check the status of rsyslog and journald: ${l_result_2}"
   fi

   l_result_3="$(if systemctl is-active --quiet rsyslog; then 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - if systemctl is-active --quiet rsyslog; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if systemctl is-active --quiet rsyslog; then: ${l_result_3}"
   fi

   l_result_4="$(l_output="$l_output\n - rsyslog is in use\n- follow the recommendations in Configure rsyslog subsection only" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - rsyslog is in use\n- follow the recommendations in Configure rsyslog subsection only": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - rsyslog is in use\n- follow the recommendations in Configure rsyslog subsection only": ${l_result_4}"
   fi

   l_result_5="$(elif systemctl is-active --quiet systemd-journald; then 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - elif systemctl is-active --quiet systemd-journald; then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif systemctl is-active --quiet systemd-journald; then: ${l_result_5}"
   fi

   l_result_6="$(l_output="$l_output\n - journald is in use\n- follow the recommendations in Configure journald subsection only" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - journald is in use\n- follow the recommendations in Configure journald subsection only": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - journald is in use\n- follow the recommendations in Configure journald subsection only": ${l_result_6}"
   fi

   l_result_7="$(else 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_7}"
   fi

   l_result_8="$(echo -e “unable to determine system logging” 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - echo -e “unable to determine system logging”: no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e “unable to determine system logging”: ${l_result_8}"
   fi

   l_result_9="$(l_output2="$l_output2\n - unable to determine system logging\n- Configure only ONE system logging: rsyslog OR journald" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - unable to determine system logging\n- Configure only ONE system logging: rsyslog OR journald": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - unable to determine system logging\n- Configure only ONE system logging: rsyslog OR journald": ${l_result_9}"
   fi

   l_result_10="$(if [ -z "$l_output2" ]; then # Provide audit results 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then # Provide audit results: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then # Provide audit results: ${l_result_10}"
   fi

   l_result_11="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_11}"
   fi

   l_result_12="$(else 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_12}"
   fi

   l_result_13="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2": ${l_result_13}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
