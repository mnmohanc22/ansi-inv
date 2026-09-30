#!/bin/bash
# 7.2.3 Ensure no duplicate UIDs exist

{
   l_output="" l_output2=""
   l_dup_uids="$(awk -F: '{print $3}' /etc/passwd | sort | uniq -d)"
   if [ -n "$l_dup_uids" ]; then
      l_output2="$l_output2\n - Duplicate UIDs found: $l_dup_uids"
   else
      l_output="$l_output\n - No duplicate UIDs found in /etc/passwd"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
