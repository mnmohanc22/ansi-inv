#!/bin/bash
# 5.4.1.1 Ensure PASS_MAX_DAYS is 365 or less

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*PASS_MAX_DAYS" /etc/login.defs 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && [ "$l_val" -le 365 ] && [ "$l_val" -gt 0 ] 2>/dev/null; then
         l_output="$l_output\n - PASS_MAX_DAYS = $l_val (acceptable: 1-365)"
      else
         l_output2="$l_output2\n - PASS_MAX_DAYS = ${l_val:-not parsed} (expected 1-365)"
      fi
   else
      l_output2="$l_output2\n - PASS_MAX_DAYS is not configured in /etc/login.defs"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
