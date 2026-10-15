#!/bin/bash
# RHL9-186 | Ensure accounts in /etc/passwd use shadowed passwords

{
   l_output="" l_output2=""

   l_result_1="$(awk -F: '($2 != "x" ) { print "User: \"" $1 "\" is not set to shadowed passwords "}' /etc/passwd 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - awk -F: '($2 != "x" ) { print "User: \"" $1 "\" is not set to shadowed passwords "}' /etc/passwd: no output (PASS)"
   else
      l_output2="$l_output2\n - awk -F: '($2 != "x" ) { print "User: \"" $1 "\" is not set to shadowed passwords "}' /etc/passwd: ${l_result_1}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
