#!/bin/bash
# 1.1.2.1.1 Ensure /tmp is a separate partition

{
   l_output="" l_output2=""

   l_findmnt="$(findmnt -nk /tmp 2>/dev/null)"
   if [ -n "$l_findmnt" ]; then
      l_output="$l_output\n - /tmp is a separate partition\n$l_findmnt"
   else
      l_output2="$l_output2\n - /tmp is not a separate partition"
   fi

   l_status="$(systemctl is-enabled tmp.mount 2>/dev/null)"
   if [[ "$l_status" =~ ^(enabled|static|generated)$ ]]; then
      l_output="$l_output\n - tmp.mount is $l_status"
   else
      l_output2="$l_output2\n - tmp.mount is not enabled/static/generated (status: ${l_status:-not found})"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
