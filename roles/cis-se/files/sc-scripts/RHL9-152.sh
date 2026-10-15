#!/bin/bash
# RHL9-152 | Ensure sudo log file exists

{
   l_output="" l_output2=""

   l_result_1="$(grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers* 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*: ${l_result_1}"
   fi

   l_result_2="$(Defaults logfile="/var/log/sudo.log" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Defaults logfile="/var/log/sudo.log": no output (PASS)"
   else
      l_output2="$l_output2\n - Defaults logfile="/var/log/sudo.log": ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
