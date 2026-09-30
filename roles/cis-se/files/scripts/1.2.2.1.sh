#!/bin/bash
# 1.2.2.1 Ensure GPG keys are configured

{
   l_output="" l_output2=""

   l_count=$(rpm -q gpg-pubkey 2>/dev/null | grep -c "gpg-pubkey")
   if [ "$l_count" -gt 0 ]; then
      l_output="$l_output\n - $l_count GPG public key(s) are installed"
      rpm -q gpg-pubkey 2>/dev/null | while read -r key; do
         echo -e "   - $key"
      done
   else
      l_output2="$l_output2\n - No GPG public keys are installed"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
