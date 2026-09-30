#!/bin/bash
# 2.4.2.1 Ensure /etc/at.deny is absent and /etc/at.allow exists

{
   l_output="" l_output2=""
   if [ -f /etc/at.deny ]; then
      l_output2="$l_output2\n - /etc/at.deny exists"
   else
      l_output="$l_output\n - /etc/at.deny does not exist"
   fi
   if [ -f /etc/at.allow ]; then
      l_output="$l_output\n - /etc/at.allow exists"
   else
      l_output2="$l_output2\n - /etc/at.allow does not exist"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
