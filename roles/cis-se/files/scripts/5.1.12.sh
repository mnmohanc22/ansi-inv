#!/bin/bash
# 5.1.12 Ensure SSH PermitEmptyPasswords is disabled

{
   l_output="" l_output2=""
   l_val="$(sshd -T 2>/dev/null | grep -i "^permitemptypasswords" | awk '{print $2}' | tr '[:upper:]' '[:lower:]')"
   if [ "$l_val" = "no" ]; then
      l_output="$l_output\n - PermitEmptyPasswords is set to no"
   else
      l_output2="$l_output2\n - PermitEmptyPasswords is set to '${l_val:-not set}' (expected no)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
