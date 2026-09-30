#!/bin/bash
# 5.3.3.3.1 Ensure password history remember is 24 or more

{
   l_output="" l_output2=""
   l_line="$(grep -Erh "pam_pwhistory.so" /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null | grep "remember")"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | grep -Eo 'remember=[0-9]+' | cut -d= -f2)"
      if [ -n "$l_val" ] && [ "$l_val" -ge 24 ] 2>/dev/null; then
         l_output="$l_output\n - pwhistory remember = $l_val (acceptable: >= 24)"
      else
         l_output2="$l_output2\n - pwhistory remember = ${l_val:-not parsed} (expected >= 24)"
      fi
   else
      l_output2="$l_output2\n - pam_pwhistory.so with remember= is not configured in PAM files"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
