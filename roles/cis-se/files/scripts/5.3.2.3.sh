#!/bin/bash
# 5.3.2.3 Ensure faillock deny is set to 5 or less

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*deny\s*=" /etc/security/faillock.conf 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk -F= '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && [ "$l_val" -le 5 ] 2>/dev/null; then
         l_output="$l_output\n - faillock deny = $l_val (acceptable: <= 5)"
      else
         l_output2="$l_output2\n - faillock deny = ${l_val:-not parsed} (expected <= 5)"
      fi
   else
      l_output2="$l_output2\n - deny is not configured in /etc/security/faillock.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
