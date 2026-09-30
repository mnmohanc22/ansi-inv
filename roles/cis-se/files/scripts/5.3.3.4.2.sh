#!/bin/bash
# 5.3.3.4.2 Ensure SHA_CRYPT_MIN_ROUNDS is 5000 or more

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*SHA_CRYPT_MIN_ROUNDS" /etc/login.defs 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk '{print $2}' | tr -d ' ')"
      if [ -n "$l_val" ] && [ "$l_val" -ge 5000 ] 2>/dev/null; then
         l_output="$l_output\n - SHA_CRYPT_MIN_ROUNDS = $l_val (acceptable: >= 5000)"
      else
         l_output2="$l_output2\n - SHA_CRYPT_MIN_ROUNDS = ${l_val:-not parsed} (expected >= 5000)"
      fi
   else
      l_output2="$l_output2\n - SHA_CRYPT_MIN_ROUNDS is not configured in /etc/login.defs"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
