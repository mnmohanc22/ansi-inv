#!/bin/bash
# 1.8.3 Ensure GDM disable-user-list option is enabled

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      l_val="$(gsettings get org.gnome.login-screen disable-user-list 2>/dev/null)"
      if [ "$l_val" = "true" ]; then
         l_output="$l_output\n - disable-user-list is set to true"
      else
         l_output2="$l_output2\n - disable-user-list is: '${l_val:-not set}' (expected true)"
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
