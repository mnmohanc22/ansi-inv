#!/bin/bash
# 4.3.2 Ensure NTP is configured in systemd-timesyncd

{
   l_output="" l_output2=""
   l_ntp="$(grep -E "^NTP=" /etc/systemd/timesyncd.conf 2>/dev/null)"
   if [ -n "$l_ntp" ]; then
      l_output="$l_output\n - NTP= is configured in /etc/systemd/timesyncd.conf: $l_ntp"
   else
      l_output2="$l_output2\n - NTP= is not configured in /etc/systemd/timesyncd.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
