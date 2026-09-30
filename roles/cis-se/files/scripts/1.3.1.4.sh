#!/bin/bash
# 1.3.1.4 Ensure filesystem integrity is regularly checked (systemd timer or cron)

{
   l_output="" l_output2=""

   l_timer=$(systemctl list-timers 2>/dev/null | grep -i aide)
   l_cron=$(grep -rh "aide --check\|aide -C" /etc/cron* /var/spool/cron/root 2>/dev/null | grep -v "^#")

   if [ -n "$l_timer" ]; then
      l_output="$l_output\n - AIDE systemd timer found:\n$l_timer"
   fi
   if [ -n "$l_cron" ]; then
      l_output="$l_output\n - AIDE cron check job found:\n$l_cron"
   fi

   if [ -z "$l_output" ]; then
      l_output2="$l_output2\n - No AIDE scheduled check found (no systemd timer or cron job for aide --check)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
