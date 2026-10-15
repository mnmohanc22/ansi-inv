#!/bin/bash
# RHL9-109 | Ensure rsyslog log file creation mode is configured

{
   l_output="" l_output2=""

   l_result_1="$(grep -Ps '^\h*\$FileCreateMode\h+0[0,2,4,6][0,2,4]0\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Ps '^\h*\$FileCreateMode\h+0[0,2,4,6][0,2,4]0\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Ps '^\h*\$FileCreateMode\h+0[0,2,4,6][0,2,4]0\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: ${l_result_1}"
   fi

   l_result_2="$($FileCreateMode 0640 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - $FileCreateMode 0640: no output (PASS)"
   else
      l_output2="$l_output2\n - $FileCreateMode 0640: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
