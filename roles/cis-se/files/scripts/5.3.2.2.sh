#!/bin/bash
# 5.3.2.2 Ensure pam_faillock authfail is configured in PAM

{
   l_output="" l_output2=""
   l_authfail="$(grep -h "pam_faillock.so authfail" /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null)"
   if [ -n "$l_authfail" ]; then
      l_output="$l_output\n - pam_faillock.so authfail is configured in PAM:\n$l_authfail"
   else
      l_output2="$l_output2\n - pam_faillock.so authfail is not configured in /etc/pam.d/system-auth or /etc/pam.d/password-auth"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
