#!/bin/bash
# 5.4.3.3 Ensure default user shell timeout (TMOUT) is 900 seconds or less

{
   l_output="" l_output2=""
   l_tmout_lines="$(grep -Erh "TMOUT" /etc/bashrc /etc/profile /etc/profile.d/ 2>/dev/null | grep -v "^#")"
   if [ -n "$l_tmout_lines" ]; then
      l_val="$(echo "$l_tmout_lines" | grep -Eo 'TMOUT=[0-9]+' | grep -Eo '[0-9]+' | sort -n | head -1)"
      if [ -n "$l_val" ] && [ "$l_val" -le 900 ] && [ "$l_val" -gt 0 ] 2>/dev/null; then
         l_output="$l_output\n - TMOUT is set to $l_val (acceptable: 1-900)"
      else
         l_output2="$l_output2\n - TMOUT = ${l_val:-not parsed} (expected 1-900)"
      fi
   else
      l_output2="$l_output2\n - TMOUT is not configured in /etc/bashrc, /etc/profile, or /etc/profile.d/"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
