#!/bin/bash
# RHL9-46 | Ensure access to /etc/motd is configured

{
   l_output="" l_output2=""

   l_result_1="$([ -e /etc/motd ] && stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/motd 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - [ -e /etc/motd ] && stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/motd: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e /etc/motd ] && stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/motd: ${l_result_1}"
   fi

   l_result_2="$(Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root) 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root): no output (PASS)"
   else
      l_output2="$l_output2\n - Access: (0644/-rw-r--r--) Uid: ( 0/ root) Gid: ( 0/ root): ${l_result_2}"
   fi

   l_result_3="$(-- OR -- 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - -- OR --: no output (PASS)"
   else
      l_output2="$l_output2\n - -- OR --: ${l_result_3}"
   fi

   l_result_4="$(Nothing is returned 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Nothing is returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing is returned: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
