#!/bin/bash
# RHL9-153 | Ensure re-authentication for privilege escalation is not disabled globally

{
   l_output="" l_output2=""

   l_result_1="$(grep -r "^[^#].*\!authenticate" /etc/sudoers* 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -r "^[^#].*\!authenticate" /etc/sudoers*: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -r "^[^#].*\!authenticate" /etc/sudoers*: ${l_result_1}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
