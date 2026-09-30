#!/bin/bash
# 5.2.2 Ensure sudo commands require authentication (no NOPASSWD)

{
   l_output="" l_output2=""
   l_nopasswd="$(grep -rh "^[^#].*NOPASSWD" /etc/sudoers /etc/sudoers.d/ 2>/dev/null)"
   if [ -n "$l_nopasswd" ]; then
      l_output2="$l_output2\n - NOPASSWD found in sudoers:\n$l_nopasswd"
   else
      l_output="$l_output\n - No NOPASSWD entries found in sudoers"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
