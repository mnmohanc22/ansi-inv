#!/bin/bash
# 4.3.3 Ensure systemd-timesyncd is active

{
   l_output="" l_output2=""
   l_state="$(systemctl is-active systemd-timesyncd 2>/dev/null)"
   if [ "$l_state" = "active" ]; then
      l_output="$l_output\n - systemd-timesyncd is active"
   else
      l_output2="$l_output2\n - systemd-timesyncd is not active (state: ${l_state:-not found})"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
