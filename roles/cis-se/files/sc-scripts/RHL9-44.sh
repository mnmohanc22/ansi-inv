#!/bin/bash
# RHL9-44 | Ensure local login warning banner is configured properly

{
   l_output="" l_output2=""

   l_result_1="$(cat /etc/issue 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - cat /etc/issue: no output (PASS)"
   else
      l_output2="$l_output2\n - cat /etc/issue: ${l_result_1}"
   fi

   l_result_2="$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
