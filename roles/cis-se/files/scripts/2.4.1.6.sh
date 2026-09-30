#!/bin/bash
# 2.4.1.6 Ensure /etc/cron.monthly has permissions 700 and is owned by root:root

{
   l_output="" l_output2=""
   l_file="/etc/cron.monthly"
   if [ -d "$l_file" ]; then
      read -r l_mode l_owner l_group <<< "$(stat -c "%a %U %G" "$l_file")"
      if [ "$l_mode" = "700" ] && [ "$l_owner" = "root" ] && [ "$l_group" = "root" ]; then
         l_output="$l_output\n - $l_file has mode $l_mode, owner $l_owner, group $l_group"
      else
         [ "$l_mode" != "700" ] && l_output2="$l_output2\n - $l_file has mode $l_mode (expected 700)"
         [ "$l_owner" != "root" ] && l_output2="$l_output2\n - $l_file is owned by $l_owner (expected root)"
         [ "$l_group" != "root" ] && l_output2="$l_output2\n - $l_file group is $l_group (expected root)"
      fi
   else
      l_output2="$l_output2\n - $l_file does not exist"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
