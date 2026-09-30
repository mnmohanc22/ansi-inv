#!/bin/bash
# 6.2.3.8 Ensure rsyslog is not configured to receive journal logs

{
   l_output="" l_output2=""
   l_imjournal="$(grep -Erh "^\s*\\\$ModLoad imjournal\|module.*imjournal" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null)"
   if [ -n "$l_imjournal" ]; then
      l_output2="$l_output2\n - rsyslog is configured to import from journal (imjournal):\n$l_imjournal"
   else
      l_output="$l_output\n - rsyslog is not configured to import from journal (imjournal not found)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
