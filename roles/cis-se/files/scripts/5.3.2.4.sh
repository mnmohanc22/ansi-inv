#!/bin/bash
# 5.3.2.4 Ensure faillock unlock_time is set to 900 or more (or 0 for never)

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*unlock_time\s*=" /etc/security/faillock.conf 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk -F= '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && { [ "$l_val" -eq 0 ] || [ "$l_val" -ge 900 ]; } 2>/dev/null; then
         l_output="$l_output\n - faillock unlock_time = $l_val (acceptable: 0 or >= 900)"
      else
         l_output2="$l_output2\n - faillock unlock_time = ${l_val:-not parsed} (expected 0 or >= 900)"
      fi
   else
      l_output2="$l_output2\n - unlock_time is not configured in /etc/security/faillock.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
