#!/bin/bash
# 1.1.2.2.1 Ensure /dev/shm is a separate partition

{
   l_output="" l_output2=""

   l_mount="/dev/shm"
   l_findmnt="$(findmnt -nk "$l_mount" 2>/dev/null)"
   if [ -n "$l_findmnt" ]; then
      l_output="$l_output\n - $l_mount is a separate partition"
   else
      l_output2="$l_output2\n - $l_mount is not a separate partition"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
