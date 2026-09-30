#!/bin/bash
# 6.2.2.1.2 Ensure rsyslog is configured to use TLS

{
   l_output="" l_output2=""
   l_tls="$(grep -Erh "DefaultNetstreamDriver\s+gtls\|omfwd.*tls" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null)"
   if [ -n "$l_tls" ]; then
      l_output="$l_output\n - rsyslog TLS is configured:\n$l_tls"
   else
      l_output2="$l_output2\n - rsyslog TLS (DefaultNetstreamDriver gtls or omfwd tls) is not configured"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
