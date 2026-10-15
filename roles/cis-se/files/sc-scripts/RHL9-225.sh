#!/bin/bash
# RHL9-225 | Ensure sshd MACs are configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -Pi -- 'macs\h+([^#\n\r]+,)?(hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1-96|umac-64@openssh\.com|hmac-md5-etm@openssh\.com|hmac-md5-96-etm@openssh\.com|hmac-ripemd160-etm@openssh\.com|hmac-sha1-96-etm@openssh\.com|umac-64-etm@openssh\.com|umac-128-etm@openssh\.com)\b' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -Pi -- 'macs\h+([^#\n\r]+,)?(hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1-96|umac-64@openssh\.com|hmac-md5-etm@openssh\.com|hmac-md5-96-etm@openssh\.com|hmac-ripemd160-etm@openssh\.com|hmac-sha1-96-etm@openssh\.com|umac-64-etm@openssh\.com|umac-128-etm@openssh\.com)\b': no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -Pi -- 'macs\h+([^#\n\r]+,)?(hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1-96|umac-64@openssh\.com|hmac-md5-etm@openssh\.com|hmac-md5-96-etm@openssh\.com|hmac-ripemd160-etm@openssh\.com|hmac-sha1-96-etm@openssh\.com|umac-64-etm@openssh\.com|umac-128-etm@openssh\.com)\b': ${l_result_1}"
   fi

   l_result_2="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_2}"
   fi

   l_result_3="$(hmac-md5 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - hmac-md5: no output (PASS)"
   else
      l_output2="$l_output2\n - hmac-md5: ${l_result_3}"
   fi

   l_result_4="$(hmac-md5-96 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - hmac-md5-96: no output (PASS)"
   else
      l_output2="$l_output2\n - hmac-md5-96: ${l_result_4}"
   fi

   l_result_5="$(hmac-sha1-96 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - hmac-sha1-96: no output (PASS)"
   else
      l_output2="$l_output2\n - hmac-sha1-96: ${l_result_5}"
   fi

   l_result_6="$(umac-64@openssh.com 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - umac-64@openssh.com: no output (PASS)"
   else
      l_output2="$l_output2\n - umac-64@openssh.com: ${l_result_6}"
   fi

   l_result_7="$(hmac-md5-etm@openssh.com 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - hmac-md5-etm@openssh.com: no output (PASS)"
   else
      l_output2="$l_output2\n - hmac-md5-etm@openssh.com: ${l_result_7}"
   fi

   l_result_8="$(hmac-md5-96-etm@openssh.com 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - hmac-md5-96-etm@openssh.com: no output (PASS)"
   else
      l_output2="$l_output2\n - hmac-md5-96-etm@openssh.com: ${l_result_8}"
   fi

   l_result_9="$(hmac-sha1-96-etm@openssh.com 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - hmac-sha1-96-etm@openssh.com: no output (PASS)"
   else
      l_output2="$l_output2\n - hmac-sha1-96-etm@openssh.com: ${l_result_9}"
   fi

   l_result_10="$(umac-64-etm@openssh.com 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - umac-64-etm@openssh.com: no output (PASS)"
   else
      l_output2="$l_output2\n - umac-64-etm@openssh.com: ${l_result_10}"
   fi

   l_result_11="$(umac-128-etm@openssh.com 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - umac-128-etm@openssh.com: no output (PASS)"
   else
      l_output2="$l_output2\n - umac-128-etm@openssh.com: ${l_result_11}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
