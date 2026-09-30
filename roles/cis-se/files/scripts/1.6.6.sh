#!/bin/bash
# 1.6.6 Ensure system-wide crypto policy disables SHA1 hash and signature support

{
   l_output="" l_output2=""
   l_pol="/etc/crypto-policies/state/CURRENT.pol"

   if [ -f "$l_pol" ]; then
      if grep -Piq '^\h*(hash|sign)\h*=\h*([^#\n\r]+\h)?SHA1\b' "$l_pol"; then
         l_output2="$l_output2\n - SHA1 is enabled in the system-wide crypto policy"
      else
         l_output="$l_output\n - SHA1 is not enabled in the system-wide crypto policy"
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
