#!/bin/bash
# 5.3.3.4.3 Ensure pam_unix is configured with sha512

{
   l_output="" l_output2=""
   l_line="$(grep -Erh "pam_unix.so" /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null | grep "sha512")"
   if [ -n "$l_line" ]; then
      l_output="$l_output\n - pam_unix.so has sha512 configured:\n$l_line"
   else
      l_output2="$l_output2\n - pam_unix.so does not have sha512 in /etc/pam.d/system-auth or /etc/pam.d/password-auth"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
