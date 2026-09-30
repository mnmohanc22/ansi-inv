#!/bin/bash
# 5.3.3.1.2 Ensure pam_pwquality does not have nullok set

{
   l_output="" l_output2=""
   l_nullok="$(grep -Erh "pam_pwquality.so" /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null | grep "nullok")"
   if [ -n "$l_nullok" ]; then
      l_output2="$l_output2\n - pam_pwquality.so has nullok set:\n$l_nullok"
   else
      l_output="$l_output\n - pam_pwquality.so does not have nullok set"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
