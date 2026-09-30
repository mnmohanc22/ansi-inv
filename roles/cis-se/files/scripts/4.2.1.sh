#!/bin/bash
# 4.2.1 Ensure chrony is configured with a remote time server

{
   l_output="" l_output2=""
   l_servers="$(grep -Erh "^(server|pool)\s" /etc/chrony.conf /etc/chrony.d/ 2>/dev/null)"
   if [ -n "$l_servers" ]; then
      l_output="$l_output\n - chrony server/pool entries found:\n$l_servers"
   else
      l_output2="$l_output2\n - No chrony server or pool entries found in /etc/chrony.conf or /etc/chrony.d/"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
