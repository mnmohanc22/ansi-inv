#!/bin/bash
# RHL9-130 | Ensure crontab is restricted to authorized users

{
   l_output="" l_output2=""

   l_result_1="$(stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.allow 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.allow: no output (PASS)"
   else
      l_output2="$l_output2\n - stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.allow: ${l_result_1}"
   fi

   l_result_2="$(Access: (640/-rw-r-----) Owner: (root) Group: (root) 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Access: (640/-rw-r-----) Owner: (root) Group: (root): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (640/-rw-r-----) Owner: (root) Group: (root): ${l_result_2}"
   fi

   l_result_3="$([ -e "/etc/cron.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.deny 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - [ -e "/etc/cron.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.deny: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "/etc/cron.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.deny: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
