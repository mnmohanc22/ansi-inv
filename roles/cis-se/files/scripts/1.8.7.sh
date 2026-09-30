#!/bin/bash
# 1.8.7 Ensure GDM disabling automatic mounting of removable media is not overridable

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      if grep -rh "automount\b" /etc/dconf/db/local.d/locks/ 2>/dev/null | grep -q "automount"; then
         l_output="$l_output\n - automount is locked via dconf"
      else
         l_output2="$l_output2\n - automount is not locked in /etc/dconf/db/local.d/locks/"
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
