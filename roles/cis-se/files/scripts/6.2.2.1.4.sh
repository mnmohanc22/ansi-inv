#!/bin/bash
# 6.2.2.1.4 Ensure rsyslog TLS authentication mode is configured

{
   l_output="" l_output2=""
   l_authmode="$(grep -Erh "ActionSendStreamDriverAuthMode\|tls.authmode" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null)"
   if [ -n "$l_authmode" ]; then
      l_output="$l_output\n - rsyslog TLS auth mode is configured:\n$l_authmode"
   else
      l_output2="$l_output2\n - rsyslog TLS auth mode (ActionSendStreamDriverAuthMode or tls.authmode) is not configured"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
