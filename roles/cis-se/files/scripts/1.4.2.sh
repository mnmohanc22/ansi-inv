#!/bin/bash
# 1.4.2 Ensure permissions on bootloader config are configured

{
   l_output="" l_output2=""

   if [ -f /boot/grub2/grub.cfg ]; then
      l_stat=$(stat -c "%a %U %G" /boot/grub2/grub.cfg 2>/dev/null)
      l_mode=$(echo "$l_stat" | awk '{print $1}')
      l_owner=$(echo "$l_stat" | awk '{print $2}')
      l_group=$(echo "$l_stat" | awk '{print $3}')

      if [ "$l_mode" -le 600 ] 2>/dev/null; then
         l_output="$l_output\n - /boot/grub2/grub.cfg permissions are $l_mode (acceptable)"
      else
         l_output2="$l_output2\n - /boot/grub2/grub.cfg permissions are $l_mode (should be 600 or less)"
      fi

      if [ "$l_owner" = "root" ]; then
         l_output="$l_output\n - /boot/grub2/grub.cfg owner is root"
      else
         l_output2="$l_output2\n - /boot/grub2/grub.cfg owner is $l_owner (should be root)"
      fi

      if [ "$l_group" = "root" ]; then
         l_output="$l_output\n - /boot/grub2/grub.cfg group is root"
      else
         l_output2="$l_output2\n - /boot/grub2/grub.cfg group is $l_group (should be root)"
      fi
   else
      l_output2="$l_output2\n - /boot/grub2/grub.cfg does not exist"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
