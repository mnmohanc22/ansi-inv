#!/bin/bash
# RHL9-131 | Ensure at is restricted to authorized users

{
   l_output="" l_output2=""

   l_result_1="$(stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.allow 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.allow: no output (PASS)"
   else
      l_output2="$l_output2\n - stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.allow: ${l_result_1}"
   fi

   l_result_2="$(Access: (640/-rw-r-----) Owner: (root) Group: (daemon) 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Access: (640/-rw-r-----) Owner: (root) Group: (daemon): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (640/-rw-r-----) Owner: (root) Group: (daemon): ${l_result_2}"
   fi

   l_result_3="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_3}"
   fi

   l_result_4="$(Access: (640/-rw-r-----) Owner: (root) Group: (root) 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Access: (640/-rw-r-----) Owner: (root) Group: (root): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (640/-rw-r-----) Owner: (root) Group: (root): ${l_result_4}"
   fi

   l_result_5="$([ -e "/etc/at.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.deny 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - [ -e "/etc/at.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.deny: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "/etc/at.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.deny: ${l_result_5}"
   fi

   l_result_6="$(Access: (640/-rw-r-----) Owner: (root) Group: (daemon) 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - Access: (640/-rw-r-----) Owner: (root) Group: (daemon): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (640/-rw-r-----) Owner: (root) Group: (daemon): ${l_result_6}"
   fi

   l_result_7="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_7}"
   fi

   l_result_8="$(Access: (640/-rw-r-----) Owner: (root) Group: (root) 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - Access: (640/-rw-r-----) Owner: (root) Group: (root): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (640/-rw-r-----) Owner: (root) Group: (root): ${l_result_8}"
   fi

   l_result_9="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_9}"
   fi

   l_result_10="$(Nothing is returned 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - Nothing is returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing is returned: ${l_result_10}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
