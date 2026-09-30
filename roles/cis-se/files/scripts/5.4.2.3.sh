#!/bin/bash
# 5.4.2.3 Ensure system accounts do not have a valid login shell

{
   l_output="" l_output2=""
   l_sysaccts="$(awk -F: '($3<1000 && $1!="root" && $7!~/nologin|false/) {print $1" (shell: "$7")"}' /etc/passwd 2>/dev/null)"
   if [ -n "$l_sysaccts" ]; then
      l_output2="$l_output2\n - System accounts with login shells:\n$l_sysaccts"
   else
      l_output="$l_output\n - All system accounts (UID<1000, excluding root) use nologin or false"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
