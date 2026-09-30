#!/bin/bash
# 7.2.5 Ensure no duplicate usernames exist

{
   l_output="" l_output2=""
   l_dup_users="$(awk -F: '{print $1}' /etc/passwd | sort | uniq -d)"
   if [ -n "$l_dup_users" ]; then
      l_output2="$l_output2\n - Duplicate usernames found: $l_dup_users"
   else
      l_output="$l_output\n - No duplicate usernames found in /etc/passwd"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
