#!/bin/bash
# 5.4.1.3 Ensure PASS_WARN_AGE is 7 or more

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*PASS_WARN_AGE" /etc/login.defs 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && [ "$l_val" -ge 7 ] 2>/dev/null; then
         l_output="$l_output\n - PASS_WARN_AGE = $l_val (acceptable: >= 7)"
      else
         l_output2="$l_output2\n - PASS_WARN_AGE = ${l_val:-not parsed} (expected >= 7)"
      fi
   else
      l_output2="$l_output2\n - PASS_WARN_AGE is not configured in /etc/login.defs"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
