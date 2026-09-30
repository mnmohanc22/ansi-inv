#!/bin/bash
# 5.4.1.6 Ensure all users with passwords have password expiry set

{
   l_output="" l_output2=""
   l_users="$(awk -F: '($2~/^\$/ && ($5=="" || $5=="99999" || $5=="0")) {print $1}' /etc/shadow 2>/dev/null)"
   if [ -n "$l_users" ]; then
      l_output2="$l_output2\n - Users with passwords but no or infinite expiry:$( echo "$l_users" | while read -r u; do echo -n "\n   - $u"; done)"
   else
      l_output="$l_output\n - All users with passwords have a password expiry set"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
