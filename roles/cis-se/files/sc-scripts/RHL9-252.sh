#!/bin/bash
# RHL9-252 | Ensure journald ForwardToSyslog is disabled

{
   l_output="" l_output2=""

   l_result_1="$(systemd-analyze cat-config systemd/journald.conf systemd/journald.conf.d/* | grep -E "^ForwardToSyslog=no" 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - systemd-analyze cat-config systemd/journald.conf systemd/journald.conf.d/* | grep -E "^ForwardToSyslog=no": no output (PASS)"
   else
      l_output2="$l_output2\n - systemd-analyze cat-config systemd/journald.conf systemd/journald.conf.d/* | grep -E "^ForwardToSyslog=no": ${l_result_1}"
   fi

   l_result_2="$(ForwardToSyslog=no 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - ForwardToSyslog=no: no output (PASS)"
   else
      l_output2="$l_output2\n - ForwardToSyslog=no: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
