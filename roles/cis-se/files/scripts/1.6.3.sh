#!/bin/bash
# 1.6.3 Ensure SELinux policy is configured

{
   l_output="" l_output2=""

   l_policy=$(sestatus 2>/dev/null | grep "Loaded policy name" | awk '{print $NF}')
   if [ "$l_policy" = "targeted" ]; then
      l_output="$l_output\n - SELinux loaded policy is 'targeted'"
   else
      l_output2="$l_output2\n - SELinux loaded policy is '$l_policy' (should be 'targeted')"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
