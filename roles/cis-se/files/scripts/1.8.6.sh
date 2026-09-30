#!/bin/bash
# 1.8.6 Ensure GDM automatic mounting of removable media is disabled

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      l_am="$(gsettings get org.gnome.desktop.media-handling automount 2>/dev/null)"
      l_ao="$(gsettings get org.gnome.desktop.media-handling automount-open 2>/dev/null)"
      [ "$l_am" = "false" ] && l_output="$l_output\n - automount is false" || l_output2="$l_output2\n - automount is: '${l_am:-not set}' (expected false)"
      [ "$l_ao" = "false" ] && l_output="$l_output\n - automount-open is false" || l_output2="$l_output2\n - automount-open is: '${l_ao:-not set}' (expected false)"
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
