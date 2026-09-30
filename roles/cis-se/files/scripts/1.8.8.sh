#!/bin/bash
# 1.8.8 Ensure GDM autorun-never is enabled

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      l_val="$(gsettings get org.gnome.desktop.media-handling autorun-never 2>/dev/null)"
      [ "$l_val" = "true" ] && l_output="$l_output\n - autorun-never is true" || l_output2="$l_output2\n - autorun-never is: '${l_val:-not set}' (expected true)"
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
