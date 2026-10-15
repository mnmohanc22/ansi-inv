#!/bin/bash
# RHL9-123 | Ensure cron daemon is enabled and active

{
   l_output="" l_output2=""

   l_result_1="$(systemctl list-unit-files | awk '$1~/^crond?\.service/{print $2}' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - systemctl list-unit-files | awk '$1~/^crond?\.service/{print $2}': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl list-unit-files | awk '$1~/^crond?\.service/{print $2}': ${l_result_1}"
   fi

   l_result_2="$(enabled 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - enabled: no output (PASS)"
   else
      l_output2="$l_output2\n - enabled: ${l_result_2}"
   fi

   l_result_3="$(systemctl list-units | awk '$1~/^crond?\.service/{print $3}' 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - systemctl list-units | awk '$1~/^crond?\.service/{print $3}': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl list-units | awk '$1~/^crond?\.service/{print $3}': ${l_result_3}"
   fi

   l_result_4="$(active 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - active: no output (PASS)"
   else
      l_output2="$l_output2\n - active: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
