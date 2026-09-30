#!/bin/bash
# 5.4.1.4 Ensure inactive account lockout is 30 days or less

{
   l_output="" l_output2=""
   l_line="$(useradd -D 2>/dev/null | grep INACTIVE)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk -F= '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && [ "$l_val" -ne -1 ] && [ "$l_val" -le 30 ] 2>/dev/null; then
         l_output="$l_output\n - INACTIVE = $l_val (acceptable: 1-30)"
      else
         l_output2="$l_output2\n - INACTIVE = ${l_val:-not parsed} (expected 1-30, not -1)"
      fi
   else
      l_output2="$l_output2\n - INACTIVE is not configured (useradd -D returned no INACTIVE line)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
