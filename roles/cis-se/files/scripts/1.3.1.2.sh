#!/bin/bash
# 1.3.1.2 Ensure filesystem integrity is regularly checked (AIDE database exists)

{
   l_output="" l_output2=""

   if [ -f /var/lib/aide/aide.db.gz ]; then
      l_output="$l_output\n - AIDE database found at /var/lib/aide/aide.db.gz"
   elif [ -f /var/lib/aide/aide.db ]; then
      l_output="$l_output\n - AIDE database found at /var/lib/aide/aide.db"
   else
      l_output2="$l_output2\n - AIDE database not found at /var/lib/aide/aide.db.gz or /var/lib/aide/aide.db"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
