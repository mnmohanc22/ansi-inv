#!/bin/bash
# 5.1.17 Ensure SSH warning banner is configured

{
   l_output="" l_output2=""
   l_val="$(sshd -T 2>/dev/null | grep -i "^banner" | awk '{print $2}')"
   if [ "$l_val" = "/etc/issue.net" ]; then
      l_output="$l_output\n - SSH Banner is set to /etc/issue.net"
   else
      l_output2="$l_output2\n - SSH Banner is set to '${l_val:-not set}' (expected /etc/issue.net)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
