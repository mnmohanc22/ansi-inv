#!/bin/bash
# 5.4.3.2 Ensure default user umask is 027 or more restrictive

{
   l_output="" l_output2=""
   l_umasks="$(grep -Erh "^\s*umask" /etc/bashrc /etc/profile /etc/profile.d/ 2>/dev/null)"
   if [ -n "$l_umasks" ]; then
      l_fail=""
      while IFS= read -r l_line; do
         l_val="$(echo "$l_line" | awk '{print $NF}' | tr -d ' ')"
         if [ -n "$l_val" ]; then
            if [ "$(( 8#$l_val & ~8#027 ))" -ne 0 ] 2>/dev/null; then
               l_fail="$l_fail\n - umask $l_val is less restrictive than 027: $l_line"
            else
               l_output="$l_output\n - umask $l_val is acceptable: $l_line"
            fi
         fi
      done <<< "$l_umasks"
      [ -n "$l_fail" ] && l_output2="$l_output2$l_fail"
   else
      l_output2="$l_output2\n - No umask settings found in /etc/bashrc, /etc/profile, or /etc/profile.d/"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
