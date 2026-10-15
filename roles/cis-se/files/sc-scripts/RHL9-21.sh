#!/bin/bash
# RHL9-21 | Ensure /dev/shm is a separate partition

{
   l_output="" l_output2=""

   l_result_1="$(findmnt -kn /dev/shm 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - findmnt -kn /dev/shm: no output (PASS)"
   else
      l_output2="$l_output2\n - findmnt -kn /dev/shm: ${l_result_1}"
   fi

   l_result_2="$(/dev/shm tmpfs tmpfs rw,nosuid,nodev,noexec,relatime,seclabel 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /dev/shm tmpfs tmpfs rw,nosuid,nodev,noexec,relatime,seclabel: no output (PASS)"
   else
      l_output2="$l_output2\n - /dev/shm tmpfs tmpfs rw,nosuid,nodev,noexec,relatime,seclabel: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
