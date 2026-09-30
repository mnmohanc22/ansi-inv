#!/bin/bash
# 2.3.2 Ensure usb-storage is disabled

{
   l_output="" l_output2=""
   if grep -rh "install usb-storage /bin/true\|install usb-storage /bin/false" /etc/modprobe.d/ 2>/dev/null | grep -q "usb-storage"; then
      l_output="$l_output\n - usb-storage is disabled via modprobe"
   else
      l_output2="$l_output2\n - usb-storage is not disabled in /etc/modprobe.d/"
   fi
   if lsmod 2>/dev/null | grep -q "^usb_storage\b"; then
      l_output2="$l_output2\n - usb_storage module is currently loaded"
   else
      l_output="$l_output\n - usb_storage module is not loaded"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
