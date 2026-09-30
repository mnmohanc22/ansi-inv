#!/bin/bash
# 4.3.4 Ensure NTP is synchronized

{
   l_output="" l_output2=""
   l_ntp_status="$(timedatectl status 2>/dev/null | grep -E "NTP service|NTP synchronized")"
   if echo "$l_ntp_status" | grep -Eiq "active|yes"; then
      l_output="$l_output\n - NTP is synchronized: $l_ntp_status"
   else
      l_output2="$l_output2\n - NTP is not synchronized or not active: ${l_ntp_status:-no output}"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
