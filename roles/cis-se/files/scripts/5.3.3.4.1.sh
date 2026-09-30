#!/bin/bash
# 5.3.3.4.1 Ensure ENCRYPT_METHOD is set to SHA512 in /etc/login.defs

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*ENCRYPT_METHOD" /etc/login.defs 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk '{print $2}' | tr '[:lower:]' '[:upper:]')"
      if [ "$l_val" = "SHA512" ]; then
         l_output="$l_output\n - ENCRYPT_METHOD is set to $l_val"
      else
         l_output2="$l_output2\n - ENCRYPT_METHOD is set to $l_val (expected SHA512)"
      fi
   else
      l_output2="$l_output2\n - ENCRYPT_METHOD is not configured in /etc/login.defs"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
