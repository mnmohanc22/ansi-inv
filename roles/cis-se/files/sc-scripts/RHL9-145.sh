#!/bin/bash
# RHL9-145 | Ensure sshd MaxAuthTries is configured

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep maxauthtries 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep maxauthtries: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep maxauthtries: ${l_result_1}"
   fi

   l_result_2="$(maxauthtries 3 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - maxauthtries 3: no output (PASS)"
   else
      l_output2="$l_output2\n - maxauthtries 3: ${l_result_2}"
   fi

   l_result_3="$(sshd -T -C user=sshuser | grep maxauthtries 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - sshd -T -C user=sshuser | grep maxauthtries: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T -C user=sshuser | grep maxauthtries: ${l_result_3}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
