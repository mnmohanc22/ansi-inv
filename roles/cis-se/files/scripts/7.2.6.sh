#!/bin/bash
# 7.2.6 Ensure no duplicate group names exist

{
   l_output="" l_output2=""
   l_dup_groups="$(awk -F: '{print $1}' /etc/group | sort | uniq -d)"
   if [ -n "$l_dup_groups" ]; then
      l_output2="$l_output2\n - Duplicate group names found: $l_dup_groups"
   else
      l_output="$l_output\n - No duplicate group names found in /etc/group"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
