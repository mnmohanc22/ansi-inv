#!/bin/bash

{
   l_output="" l_output2=""
   l_crypto_pol="$(update-crypto-policies --show 2>/dev/null)"

   if grep -Piq -- '^\s*LEGACY\s*$' <<< "$l_crypto_pol"; then
      l_output2="$l_output2\n - System wide crypto policy is set to: \"$l_crypto_pol\""
   elif [ -z "$l_crypto_pol" ]; then
      l_output2="$l_output2\n - Unable to determine crypto policy (update-crypto-policies not found or returned empty)"
   else
      l_output="$l_output\n - System wide crypto policy is set to: \"$l_crypto_pol\""
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
