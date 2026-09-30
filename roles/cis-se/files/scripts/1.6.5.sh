#!/bin/bash
# 1.6.5 Ensure system-wide crypto policy disables CBC for SSH

{
   l_output="" l_output2=""
   l_pol="/etc/crypto-policies/state/CURRENT.pol"

   if [ -f "$l_pol" ]; then
      if grep -Piq '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*([^#\n\r]+)?-CBC\b' "$l_pol"; then
         l_output2="$l_output2\n - CBC cipher is enabled for SSH in crypto policy"
      else
         l_output="$l_output\n - CBC cipher is not enabled for SSH in crypto policy"
      fi
   else
      l_output2="$l_output2\n - Crypto policy state file not found: $l_pol"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
