#!/bin/bash
# 1.3.1.8 Ensure AIDE checks ACL (acl attribute configured)

{
   l_output="" l_output2=""

   l_acl=$(grep -ih "acl" /etc/aide.conf 2>/dev/null)
   if [ -n "$l_acl" ]; then
      l_output="$l_output\n - ACL is configured in /etc/aide.conf"
   else
      l_output2="$l_output2\n - ACL is not configured in /etc/aide.conf"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
