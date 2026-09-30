#!/bin/bash
# 5.3.3.2.4 Ensure password ucredit is -1 or less

{
   l_output="" l_output2=""
   l_line="$(grep -Erh "^\s*ucredit" /etc/security/pwquality.conf /etc/security/pwquality.conf.d/ 2>/dev/null | tail -1)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk -F= '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && [ "$l_val" -le -1 ] 2>/dev/null; then
         l_output="$l_output\n - ucredit = $l_val (acceptable: <= -1)"
      else
         l_output2="$l_output2\n - ucredit = ${l_val:-not parsed} (expected <= -1)"
      fi
   else
      l_output2="$l_output2\n - ucredit is not configured in pwquality.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
