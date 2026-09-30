#!/bin/bash
# 5.4.2.2 Ensure only root has UID 0

{
   l_output="" l_output2=""
   l_uid0_users="$(awk -F: '($3==0 && $1!="root") {print $1}' /etc/passwd 2>/dev/null)"
   if [ -n "$l_uid0_users" ]; then
      l_output2="$l_output2\n - Non-root users with UID 0: $( echo "$l_uid0_users" | tr '\n' ' ')"
   else
      l_output="$l_output\n - Only root has UID 0"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
