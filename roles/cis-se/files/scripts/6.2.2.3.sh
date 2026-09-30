#!/bin/bash
# 6.2.2.3 Ensure rsyslog forwards logs to a remote log host

{
   l_output="" l_output2=""
   l_remote="$(grep -Erh "^[^#].*(@@?)" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null)"
   if [ -n "$l_remote" ]; then
      l_output="$l_output\n - rsyslog remote log forwarding is configured:\n$l_remote"
   else
      l_output2="$l_output2\n - rsyslog remote log forwarding is not configured in /etc/rsyslog.conf or /etc/rsyslog.d/"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
