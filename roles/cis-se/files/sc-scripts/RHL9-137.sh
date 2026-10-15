#!/bin/bash
# RHL9-137 | Ensure sshd UsePAM is enabled

{
   l_output="" l_output2=""

   l_result_1="$(sshd -T | grep -i usepam 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - sshd -T | grep -i usepam: no output (PASS)"
   else
      l_output2="$l_output2\n - sshd -T | grep -i usepam: ${l_result_1}"
   fi

   l_result_2="$(usepam yes 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - usepam yes: no output (PASS)"
   else
      l_output2="$l_output2\n - usepam yes: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
