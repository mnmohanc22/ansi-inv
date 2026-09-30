#!/bin/bash
# 1.3.1.7 Ensure AIDE uses SHA-512 for file integrity

{
   l_output="" l_output2=""

   l_sha512=$(grep -ih "sha512" /etc/aide.conf 2>/dev/null)
   if [ -n "$l_sha512" ]; then
      l_output="$l_output\n - SHA512 is configured in /etc/aide.conf"
   else
      l_output2="$l_output2\n - SHA512 is not configured in /etc/aide.conf"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
