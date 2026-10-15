#!/bin/bash
# RHL9-115 | Ensure journald Storage is configured

{
   l_output="" l_output2=""

   l_result_1="$(systemd-analyze cat-config systemd/journald.conf systemd/journald.conf.d/* | grep -E "^Storage=persistent" 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - systemd-analyze cat-config systemd/journald.conf systemd/journald.conf.d/* | grep -E "^Storage=persistent": no output (PASS)"
   else
      l_output2="$l_output2\n - systemd-analyze cat-config systemd/journald.conf systemd/journald.conf.d/* | grep -E "^Storage=persistent": ${l_result_1}"
   fi

   l_result_2="$(Storage=persistent 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Storage=persistent: no output (PASS)"
   else
      l_output2="$l_output2\n - Storage=persistent: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
