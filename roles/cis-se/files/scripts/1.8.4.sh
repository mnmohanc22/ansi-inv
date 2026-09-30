#!/bin/bash
# 1.8.4 Ensure GDM screen locks when the user is idle

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      l_lock="$(gsettings get org.gnome.desktop.screensaver lock-enabled 2>/dev/null)"
      l_idle="$(gsettings get org.gnome.desktop.session idle-delay 2>/dev/null | grep -oP '\d+')"
      [ "$l_lock" = "true" ] && l_output="$l_output\n - screensaver lock-enabled is true" || l_output2="$l_output2\n - screensaver lock-enabled is: '${l_lock:-not set}'"
      if [ -n "$l_idle" ] && [ "$l_idle" -le 900 ] && [ "$l_idle" -gt 0 ]; then
         l_output="$l_output\n - idle-delay is $l_idle seconds"
      else
         l_output2="$l_output2\n - idle-delay is '${l_idle:-not set}' (expected 1-900)"
      fi
   else
      l_output="$l_output\n - GDM is not installed - not applicable"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
