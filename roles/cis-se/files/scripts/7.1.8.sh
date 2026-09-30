#!/bin/bash
# 7.1.8 Ensure /etc/gshadow- has mode 0 or 640, owner root, group shadow or root

{
   l_output="" l_output2=""
   l_file="/etc/gshadow-"
   read -r l_mode l_owner l_group <<< "$(stat -c "%a %U %G" "$l_file" 2>/dev/null)"
   l_mode_ok=false
   l_owner_ok=false
   l_group_ok=false
   ( [ "$l_mode" = "0" ] || [ "$l_mode" = "640" ] || [ "$l_mode" = "000" ] ) && l_mode_ok=true
   [ "$l_owner" = "root" ] && l_owner_ok=true
   ( [ "$l_group" = "shadow" ] || [ "$l_group" = "root" ] ) && l_group_ok=true
   if $l_mode_ok && $l_owner_ok && $l_group_ok; then
      l_output="$l_output\n - $l_file has mode $l_mode, owner $l_owner, group $l_group"
   else
      $l_mode_ok || l_output2="$l_output2\n - $l_file has mode $l_mode (expected 0 or 640)"
      $l_owner_ok || l_output2="$l_output2\n - $l_file is owned by $l_owner (expected root)"
      $l_group_ok || l_output2="$l_output2\n - $l_file group is $l_group (expected shadow or root)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
