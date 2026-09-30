#!/bin/bash
# 7.2.7 Ensure the shadow group is empty

{
   l_output="" l_output2=""
   l_shadow_members="$(grep "^shadow:" /etc/group 2>/dev/null | awk -F: '{print $4}')"
   if [ -n "$l_shadow_members" ]; then
      l_output2="$l_output2\n - shadow group has members: $l_shadow_members"
   else
      l_output="$l_output\n - shadow group is empty"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
