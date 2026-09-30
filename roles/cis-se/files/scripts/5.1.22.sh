#!/bin/bash
# 5.1.22 Ensure SSH Ciphers do not include weak algorithms

{
   l_output="" l_output2=""
   l_ciphers="$(sshd -T 2>/dev/null | grep -i "^ciphers" | cut -d' ' -f2)"
   if [ -n "$l_ciphers" ]; then
      if echo "$l_ciphers" | grep -Eiq "3des|aes128-cbc|aes192-cbc|aes256-cbc"; then
         l_output2="$l_output2\n - Weak ciphers detected: $l_ciphers"
      else
         l_output="$l_output\n - No weak ciphers found in SSH cipher list: $l_ciphers"
      fi
   else
      l_output2="$l_output2\n - Could not determine SSH ciphers (sshd -T returned no output)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
