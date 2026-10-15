#!/bin/bash
# RHL9-151 | Ensure sudo commands use pty

{
   l_output="" l_output2=""

   l_result_1="$(grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,\h*)?use_pty\b' /etc/sudoers* 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,\h*)?use_pty\b' /etc/sudoers*: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -rPi -- '^\h*Defaults\h+([^#\n\r]+,\h*)?use_pty\b' /etc/sudoers*: ${l_result_1}"
   fi

   l_result_2="$(/etc/sudoers:Defaults use_pty 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/sudoers:Defaults use_pty: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/sudoers:Defaults use_pty: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
