#!/bin/bash
# RHL9-124 | Ensure permissions on /etc/crontab are configured

{
   l_output="" l_output2=""

   l_result_1="$(stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab: no output (PASS)"
   else
      l_output2="$l_output2\n - stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab: ${l_result_1}"
   fi

   l_result_2="$(Access: (600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root) 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Access: (600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root): ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
