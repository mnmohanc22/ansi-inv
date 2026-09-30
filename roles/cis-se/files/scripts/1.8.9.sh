#!/bin/bash
# 1.8.9 Ensure GDM autorun-never cannot be overridden

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      if grep -rh "autorun-never" /etc/dconf/db/local.d/locks/ 2>/dev/null | grep -q "autorun-never"; then
         l_output="$l_output\n - autorun-never is locked via dconf"
      else
         l_output2="$l_output2\n - autorun-never is not locked in /etc/dconf/db/local.d/locks/"
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
