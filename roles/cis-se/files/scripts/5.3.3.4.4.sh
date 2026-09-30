#!/bin/bash
# 5.3.3.4.4 Ensure authselect uses sha512 or ENCRYPT_METHOD is SHA512

{
   l_output="" l_output2=""
   l_sha512_authsel="$(authselect current 2>/dev/null | grep "with-sha512")"
   l_sha512_logindefs="$(grep -E "^\s*ENCRYPT_METHOD\s+SHA512" /etc/login.defs 2>/dev/null)"
   if [ -n "$l_sha512_authsel" ]; then
      l_output="$l_output\n - authselect has with-sha512 configured: $l_sha512_authsel"
   elif [ -n "$l_sha512_logindefs" ]; then
      l_output="$l_output\n - ENCRYPT_METHOD=SHA512 is set in /etc/login.defs"
   else
      l_output2="$l_output2\n - Neither authselect with-sha512 nor ENCRYPT_METHOD=SHA512 is configured"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
