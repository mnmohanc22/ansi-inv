#!/bin/bash
# 1.8.2 Ensure GDM login banner is configured

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      if grep -rh "banner-message-enable=true" /etc/dconf/db/gdm.d/ 2>/dev/null | grep -q "true"; then
         l_output="$l_output\n - GDM login banner is enabled"
      else
         l_output2="$l_output2\n - GDM login banner is not enabled in /etc/dconf/db/gdm.d/"
      fi
      if grep -rh "banner-message-text" /etc/dconf/db/gdm.d/ 2>/dev/null | grep -qv "^$"; then
         l_output="$l_output\n - GDM login banner text is configured"
      else
         l_output2="$l_output2\n - GDM login banner text is not configured"
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
