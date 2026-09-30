#!/bin/bash
# 1.3.1.3 Ensure filesystem integrity is regularly checked (cron entry for AIDE)

{
   l_output="" l_output2=""

   l_cron_entry=$(grep -rh "aide" /etc/cron* /var/spool/cron/root 2>/dev/null | grep -v "^#")
   if [ -n "$l_cron_entry" ]; then
      l_output="$l_output\n - AIDE cron job found:\n$l_cron_entry"
   else
      l_output2="$l_output2\n - No cron job found for AIDE in /etc/cron* or /var/spool/cron/root"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
