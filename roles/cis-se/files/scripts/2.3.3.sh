#!/bin/bash
# 2.3.3 Ensure usb-storage is blacklisted

{
   l_output="" l_output2=""
   if grep -rh "^blacklist usb-storage" /etc/modprobe.d/ 2>/dev/null | grep -q "usb-storage"; then
      l_output="$l_output\n - usb-storage is blacklisted in /etc/modprobe.d/"
   else
      l_output2="$l_output2\n - usb-storage is not blacklisted in /etc/modprobe.d/"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
