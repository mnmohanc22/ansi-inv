#!/bin/bash
# 2.4.1.8 Ensure /etc/cron.deny is absent and /etc/cron.allow exists

{
   l_output="" l_output2=""
   if [ -f /etc/cron.deny ]; then
      l_output2="$l_output2\n - /etc/cron.deny exists"
   else
      l_output="$l_output\n - /etc/cron.deny does not exist"
   fi
   if [ -f /etc/cron.allow ]; then
      l_output="$l_output\n - /etc/cron.allow exists"
   else
      l_output2="$l_output2\n - /etc/cron.allow does not exist"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
