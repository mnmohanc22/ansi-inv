#!/bin/bash
# 5.3.3.1.1 Ensure pam_pwquality is configured in PAM files

{
   l_output="" l_output2=""
   l_pwq="$(grep -Erh "pam_pwquality.so" /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null)"
   if [ -n "$l_pwq" ]; then
      l_output="$l_output\n - pam_pwquality.so is configured in PAM files:\n$l_pwq"
   else
      l_output2="$l_output2\n - pam_pwquality.so is not configured in /etc/pam.d/system-auth or /etc/pam.d/password-auth"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
