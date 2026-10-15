#!/bin/bash
# RHL9-239 | Ensure password history is enforced for the root user

{
   l_output="" l_output2=""

   l_result_1="$(grep -Pi -- '^\h*enforce_for_root\b' /etc/security/pwhistory.conf 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Pi -- '^\h*enforce_for_root\b' /etc/security/pwhistory.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pi -- '^\h*enforce_for_root\b' /etc/security/pwhistory.conf: ${l_result_1}"
   fi

   l_result_2="$(enforce_for_root 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - enforce_for_root: no output (PASS)"
   else
      l_output2="$l_output2\n - enforce_for_root: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
