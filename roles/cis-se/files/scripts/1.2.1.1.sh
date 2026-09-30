#!/bin/bash
# 1.2.1.1 Ensure GPG keys are configured / system is up to date

{
   l_output="" l_output2=""

   dnf check-update 2>/dev/null
   rc=$?
   if [ "$rc" -eq 0 ]; then
      l_output="$l_output\n - System is up to date (no updates available)"
   elif [ "$rc" -eq 100 ]; then
      l_output2="$l_output2\n - System has updates available (dnf check-update returned 100)"
   else
      l_output2="$l_output2\n - Unable to determine update status (dnf check-update returned $rc)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
