#!/bin/bash
# 5.2.6 Ensure sudo logfile is configured

{
   l_output="" l_output2=""
   l_logfile="$(grep -rh "^Defaults.*logfile" /etc/sudoers /etc/sudoers.d/ 2>/dev/null)"
   if [ -n "$l_logfile" ]; then
      l_output="$l_output\n - logfile is configured in sudoers: $l_logfile"
   else
      l_output2="$l_output2\n - logfile is not configured in sudoers"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
