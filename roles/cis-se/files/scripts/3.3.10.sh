#!/bin/bash
# 3.3.10 Ensure ICMP redirects are not accepted

{
   l_output="" l_output2=""

   for l_param in net.ipv4.conf.all.accept_redirects net.ipv4.conf.default.accept_redirects; do
      l_val="$(sysctl "$l_param" 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')"
      if [ "$l_val" = "0" ]; then
         l_output="$l_output\n - $l_param = $l_val"
      else
         l_output2="$l_output2\n - $l_param = ${l_val:-not set} (expected 0)"
      fi
   done

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
