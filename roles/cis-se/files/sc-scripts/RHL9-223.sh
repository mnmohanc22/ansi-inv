#!/bin/bash
# RHL9-223 | Ensure sshd Ciphers are configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -Pi -- '^ciphers\h+\"?([^#\n\r]+,)?((3des|blowfish|cast128|aes(128|192|256))-cbc|arcfour(128|256)?|rijndael-cbc@lysator\.liu\.se|chacha20-poly1305@openssh\.com)\b' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -Pi -- '^ciphers\h+\"?([^#\n\r]+,)?((3des|blowfish|cast128|aes(128|192|256))-cbc|arcfour(128|256)?|rijndael-cbc@lysator\.liu\.se|chacha20-poly1305@openssh\.com)\b': no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -Pi -- '^ciphers\h+\"?([^#\n\r]+,)?((3des|blowfish|cast128|aes(128|192|256))-cbc|arcfour(128|256)?|rijndael-cbc@lysator\.liu\.se|chacha20-poly1305@openssh\.com)\b': ${l_result_1}"
   fi

   l_result_2="$(3des-cbc 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - 3des-cbc: no output (PASS)"
   else
      l_output2="$l_output2\n - 3des-cbc: ${l_result_2}"
   fi

   l_result_3="$(aes128-cbc 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - aes128-cbc: no output (PASS)"
   else
      l_output2="$l_output2\n - aes128-cbc: ${l_result_3}"
   fi

   l_result_4="$(aes192-cbc 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - aes192-cbc: no output (PASS)"
   else
      l_output2="$l_output2\n - aes192-cbc: ${l_result_4}"
   fi

   l_result_5="$(aes256-cbc 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - aes256-cbc: no output (PASS)"
   else
      l_output2="$l_output2\n - aes256-cbc: ${l_result_5}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
