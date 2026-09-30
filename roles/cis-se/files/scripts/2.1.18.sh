#!/bin/bash
# 2.1.18 Ensure rsync-daemon is not installed and rsyncd is not enabled

{
   l_output="" l_output2=""
   if rpm -q rsync-daemon &>/dev/null; then
      l_output2="$l_output2\n - rsync-daemon is installed: $(rpm -q rsync-daemon)"
   else
      l_output="$l_output\n - rsync-daemon is not installed"
   fi
   l_state="$(systemctl is-enabled rsyncd 2>/dev/null)"
   if [ "$l_state" = "enabled" ]; then
      l_output2="$l_output2\n - rsyncd.service is enabled"
   else
      l_output="$l_output\n - rsyncd.service is not enabled (state: ${l_state:-not found})"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
