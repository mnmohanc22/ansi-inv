#!/bin/bash
# RHL9-122 | Ensure systemd-journal-remote service is not in use

{
   l_output="" l_output2=""

   l_result_1="$(systemctl is-enabled systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^enabled' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - systemctl is-enabled systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^enabled': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-enabled systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^enabled': ${l_result_1}"
   fi

   l_result_2="$(systemctl is-active systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^active' 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - systemctl is-active systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^active': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-active systemd-journal-remote.socket systemd-journal-remote.service | grep -P -- '^active': ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
