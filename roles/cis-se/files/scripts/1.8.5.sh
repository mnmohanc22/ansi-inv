#!/bin/bash
# 1.8.5 Ensure GDM screen locks cannot be overridden

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      if grep -rh "lock-enabled" /etc/dconf/db/local.d/locks/ 2>/dev/null | grep -q "lock-enabled"; then
         l_output="$l_output\n - lock-enabled is locked via dconf"
      else
         l_output2="$l_output2\n - lock-enabled is not locked in /etc/dconf/db/local.d/locks/"
      fi
      if grep -rh "idle-delay" /etc/dconf/db/local.d/locks/ 2>/dev/null | grep -q "idle-delay"; then
         l_output="$l_output\n - idle-delay is locked via dconf"
      else
         l_output2="$l_output2\n - idle-delay is not locked in /etc/dconf/db/local.d/locks/"
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
