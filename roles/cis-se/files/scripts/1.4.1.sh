#!/bin/bash
# 1.4.1 Ensure bootloader password is set

{
   l_output="" l_output2=""

   l_grub_pass=$(grep -E "^set superusers|^password_pbkdf2" /boot/grub2/grub.cfg 2>/dev/null)
   l_user_cfg=$(grep "^password" /boot/grub2/user.cfg 2>/dev/null)

   if [ -n "$l_grub_pass" ] || [ -n "$l_user_cfg" ]; then
      l_output="$l_output\n - Bootloader password is configured"
      [ -n "$l_grub_pass" ] && l_output="$l_output\n   (found in /boot/grub2/grub.cfg)"
      [ -n "$l_user_cfg" ] && l_output="$l_output\n   (found in /boot/grub2/user.cfg)"
   else
      l_output2="$l_output2\n - No bootloader password found in /boot/grub2/grub.cfg or /boot/grub2/user.cfg"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
