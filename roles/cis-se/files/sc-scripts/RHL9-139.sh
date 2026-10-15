#!/bin/bash
# RHL9-139 | Ensure sshd HostbasedAuthentication is disabled

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep hostbasedauthentication 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep hostbasedauthentication: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep hostbasedauthentication: ${l_result_1}"
   fi

   l_result_2="$(hostbasedauthentication no 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - hostbasedauthentication no: no output (PASS)"
   else
      l_output2="$l_output2\n - hostbasedauthentication no: ${l_result_2}"
   fi

   l_result_3="$(sshd -T -C user=sshuser | grep hostbasedauthentication 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - sshd -T -C user=sshuser | grep hostbasedauthentication: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T -C user=sshuser | grep hostbasedauthentication: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
