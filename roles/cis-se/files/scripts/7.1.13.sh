#!/bin/bash
# 7.1.13 Audit SUID/SGID executables (informational)

{
   l_output="" l_output2=""
   l_suid_sgid="$(find / -xdev \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null)"
   if [ -n "$l_suid_sgid" ]; then
      l_output="$l_output\n - SUID/SGID files found (review list for unauthorized entries):\n$l_suid_sgid"
   else
      l_output="$l_output\n - No SUID/SGID files found"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
