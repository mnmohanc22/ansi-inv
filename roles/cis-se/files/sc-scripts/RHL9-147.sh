#!/bin/bash
# RHL9-147 | Ensure sshd MaxSessions is configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -i maxsessions 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -i maxsessions: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -i maxsessions: ${l_result_1}"
   fi

   l_result_2="$(maxsessions 10 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - maxsessions 10: no output (PASS)"
   else
      l_output2="$l_output2\n - maxsessions 10: ${l_result_2}"
   fi

   l_result_3="$(grep -Psi -- '^\h*MaxSessions\h+\"?(1[1-9]|[2-9][0-9]|[1-9][0-9][0-9]+)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*MaxSessions\h+\"?(1[1-9]|[2-9][0-9]|[1-9][0-9][0-9]+)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*MaxSessions\h+\"?(1[1-9]|[2-9][0-9]|[1-9][0-9][0-9]+)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf: ${l_result_3}"
   fi

   l_result_4="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
