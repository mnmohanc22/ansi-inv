#!/bin/bash
# 4.1.2 Ensure only one time synchronization daemon is active

{
   l_output="" l_output2=""
   l_count=0
   systemctl is-enabled chronyd 2>/dev/null | grep -q "^enabled" && l_count=$((l_count+1))
   systemctl is-enabled ntpd 2>/dev/null | grep -q "^enabled" && l_count=$((l_count+1))
   systemctl is-enabled systemd-timesyncd 2>/dev/null | grep -q "^enabled" && l_count=$((l_count+1))
   if [ "$l_count" -le 1 ]; then
      l_output="$l_output\n - Only one time sync daemon is active (count: $l_count)"
   else
      l_output2="$l_output2\n - Multiple time sync daemons are enabled (count: $l_count)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
