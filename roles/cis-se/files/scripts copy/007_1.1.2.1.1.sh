#!/bin/bash

{
   l_output="" l_output2=""

   l_findmnt_out="$(findmnt -nk /tmp 2>/dev/null)"
   if [ -n "$l_findmnt_out" ]; then
      l_output="$l_output\n - /tmp is a separate partition:\n$l_findmnt_out"
   else
      l_output2="$l_output2\n - /tmp is not mounted as a separate partition"
   fi

   l_tmp_mount_state="$(systemctl is-enabled tmp.mount 2>/dev/null)"
   if [ "$l_tmp_mount_state" = "enabled" ] || [ "$l_tmp_mount_state" = "static" ] || [ "$l_tmp_mount_state" = "generated" ]; then
      l_output="$l_output\n - tmp.mount is: \"$l_tmp_mount_state\""
   else
      l_output2="$l_output2\n - tmp.mount is: \"${l_tmp_mount_state:-not found}\""
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
