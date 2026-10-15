#!/bin/bash
# RHL9-121 | Ensure systemd-journal-upload is enabled and active

{
   l_output="" l_output2=""

   l_result_1="$(systemctl is-enabled systemd-journal-upload.service 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - systemctl is-enabled systemd-journal-upload.service: no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-enabled systemd-journal-upload.service: ${l_result_1}"
   fi

   l_result_2="$(enabled 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - enabled: no output (PASS)"
   else
      l_output2="$l_output2\n - enabled: ${l_result_2}"
   fi

   l_result_3="$(systemctl is-active systemd-journal-upload.service 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - systemctl is-active systemd-journal-upload.service: no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-active systemd-journal-upload.service: ${l_result_3}"
   fi

   l_result_4="$(active 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - active: no output (PASS)"
   else
      l_output2="$l_output2\n - active: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
