#!/bin/bash
# 3.1.3 Ensure bluetooth services are not in use

{
   l_output="" l_output2=""

   if rpm -q bluez &>/dev/null; then
      l_state="$(systemctl is-enabled bluetooth 2>/dev/null)"
      if [ "$l_state" = "enabled" ]; then
         l_output2="$l_output2\n - bluez is installed and bluetooth.service is enabled"
      else
         l_output2="$l_output2\n - bluez is installed (service state: ${l_state:-not found})"
      fi
   else
      l_output="$l_output\n - bluez is not installed"
   fi

   if systemctl is-active bluetooth &>/dev/null; then
      l_output2="$l_output2\n - bluetooth.service is currently active"
   else
      l_output="$l_output\n - bluetooth.service is not active"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
