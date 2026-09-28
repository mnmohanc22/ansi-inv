#!/bin/bash
# 2.1.9 Ensure network file system services are not in use

{
   l_output="" l_output2=""

   if rpm -q nfs-utils &>/dev/null; then
      l_output="$l_output\n - nfs-utils is installed: $(rpm -q nfs-utils)"

      if systemctl is-enabled nfs-server.service 2>/dev/null | grep -q 'enabled'; then
         l_output2="$l_output2\n - nfs-server.service is enabled"
      else
         l_output="$l_output\n - nfs-server.service is not enabled (installed as dependency only)"
      fi
   else
      l_output="$l_output\n - nfs-utils is not installed"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
