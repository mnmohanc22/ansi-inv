#!/bin/bash
# RHL9-119 | Ensure systemd-journal-remote is installed

{
   l_output="" l_output2=""

   l_result_1="$(rpm -q systemd-journal-remote 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - rpm -q systemd-journal-remote: no output (PASS)"
   else
      l_output2="$l_output2\n - rpm -q systemd-journal-remote: ${l_result_1}"
   fi

   l_result_2="$(systemd-journal-remote-<version> 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - systemd-journal-remote-<version>: no output (PASS)"
   else
      l_output2="$l_output2\n - systemd-journal-remote-<version>: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
