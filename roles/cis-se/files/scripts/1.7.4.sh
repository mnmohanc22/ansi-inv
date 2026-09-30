#!/bin/bash
# 1.7.4 Ensure permissions on /etc/motd are configured

{
   l_output="" l_output2=""

   if [ -f /etc/motd ]; then
      l_stat="$(stat -c "%a %U %G" /etc/motd 2>/dev/null)"
      l_mode="$(echo "$l_stat" | awk '{print $1}')"
      l_user="$(echo "$l_stat" | awk '{print $2}')"
      l_group="$(echo "$l_stat" | awk '{print $3}')"
      [ "$l_user" = "root" ] && l_output="$l_output\n - owner is root" || l_output2="$l_output2\n - owner is $l_user (expected root)"
      [ "$l_group" = "root" ] && l_output="$l_output\n - group is root" || l_output2="$l_output2\n - group is $l_group (expected root)"
      [ "$l_mode" -le 644 ] 2>/dev/null && l_output="$l_output\n - mode is $l_mode" || l_output2="$l_output2\n - mode is $l_mode (expected 644 or more restrictive)"
   else
      l_output="$l_output\n - /etc/motd does not exist"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
