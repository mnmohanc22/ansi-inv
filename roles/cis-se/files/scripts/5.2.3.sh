#!/bin/bash
# 5.2.3 Ensure sudo authentication cannot be bypassed (!authenticate)

{
   l_output="" l_output2=""
   l_noauth="$(grep -rh "^[^#].*!authenticate" /etc/sudoers /etc/sudoers.d/ 2>/dev/null)"
   if [ -n "$l_noauth" ]; then
      l_output2="$l_output2\n - !authenticate found in sudoers:\n$l_noauth"
   else
      l_output="$l_output\n - No !authenticate entries found in sudoers"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
