#!/bin/bash
# 1.6.1 Ensure system-wide crypto policy is not set to legacy

{
   l_output="" l_output2=""

   l_policy=$(update-crypto-policies --show 2>/dev/null)
   if [ -n "$l_policy" ]; then
      if echo "$l_policy" | grep -qi "LEGACY"; then
         l_output2="$l_output2\n - System crypto policy is set to LEGACY (should not be LEGACY)"
      else
         l_output="$l_output\n - System crypto policy is set to $l_policy (not LEGACY)"
      fi
   else
      l_output2="$l_output2\n - Unable to determine crypto policy (update-crypto-policies not available or returned empty)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
