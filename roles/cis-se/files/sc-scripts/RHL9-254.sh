#!/bin/bash
# RHL9-254 | Ensure permissions on /etc/security/opasswd are configured

{
   l_output="" l_output2=""

   l_result_1="$([ -e "/etc/security/opasswd" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - [ -e "/etc/security/opasswd" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "/etc/security/opasswd" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd: ${l_result_1}"
   fi

   l_result_2="$(/etc/security/opasswd Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root) 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/security/opasswd Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root): no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/security/opasswd Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root): ${l_result_2}"
   fi

   l_result_3="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_3}"
   fi

   l_result_4="$(Nothing is returned 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Nothing is returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing is returned: ${l_result_4}"
   fi

   l_result_5="$([ -e "/etc/security/opasswd.old" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd.old 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - [ -e "/etc/security/opasswd.old" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd.old: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -e "/etc/security/opasswd.old" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd.old: ${l_result_5}"
   fi

   l_result_6="$(/etc/security/opasswd.old Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root) 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - /etc/security/opasswd.old Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root): no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/security/opasswd.old Access: (0600/-rw-------) Uid: ( 0/ root) Gid: ( 0/ root): ${l_result_6}"
   fi

   l_result_7="$(-OR- 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - -OR-: no output (PASS)"
   else
      l_output2="$l_output2\n - -OR-: ${l_result_7}"
   fi

   l_result_8="$(Nothing is returned 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - Nothing is returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing is returned: ${l_result_8}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
