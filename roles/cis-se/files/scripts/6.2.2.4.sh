#!/bin/bash
# 6.2.2.4 Ensure rsyslog is not configured to accept logs from a remote client

{
   l_output="" l_output2=""
   l_accepting="$(grep -Erh "^\\\$ModLoad imtcp|^\\\$ModLoad imudp|^module.*imtcp|^module.*imudp" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null)"
   if [ -n "$l_accepting" ]; then
      l_output2="$l_output2\n - rsyslog is configured to accept remote logs (imtcp/imudp loaded):\n$l_accepting"
   else
      l_output="$l_output\n - rsyslog is not configured to accept remote logs (imtcp/imudp not loaded)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
