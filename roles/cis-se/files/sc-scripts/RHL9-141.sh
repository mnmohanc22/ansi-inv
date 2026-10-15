#!/bin/bash
# RHL9-141 | Ensure sshd PermitUserEnvironment is disabled

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep permituserenvironment 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep permituserenvironment: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep permituserenvironment: ${l_result_1}"
   fi

   l_result_2="$(permituserenvironment no 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - permituserenvironment no: no output (PASS)"
   else
      l_output2="$l_output2\n - permituserenvironment no: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
