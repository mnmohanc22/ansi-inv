#!/bin/bash
# 5.3.3.3.2 Ensure password history enforce_for_root is configured

{
   l_output="" l_output2=""
   l_line="$(grep -Erh "pam_pwhistory.so" /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null | grep "enforce_for_root")"
   if [ -n "$l_line" ]; then
      l_output="$l_output\n - pam_pwhistory.so has enforce_for_root configured:\n$l_line"
   else
      l_output2="$l_output2\n - pam_pwhistory.so enforce_for_root is not configured in PAM files"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
