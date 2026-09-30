#!/bin/bash
# 4.1.1 Ensure a time synchronization daemon is installed and enabled

{
   l_output="" l_output2=""
   if rpm -q chrony &>/dev/null; then
      l_output="$l_output\n - chrony is installed: $(rpm -q chrony)"
   elif rpm -q ntp &>/dev/null; then
      l_output="$l_output\n - ntp is installed: $(rpm -q ntp)"
   elif systemctl is-enabled systemd-timesyncd 2>/dev/null | grep -q "enabled"; then
      l_output="$l_output\n - systemd-timesyncd is enabled"
   else
      l_output2="$l_output2\n - No time synchronization daemon is installed or enabled"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
