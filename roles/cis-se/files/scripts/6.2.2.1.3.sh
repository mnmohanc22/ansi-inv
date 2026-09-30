#!/bin/bash
# 6.2.2.1.3 Ensure rsyslog TLS CA certificate is configured

{
   l_output="" l_output2=""
   l_cacert="$(grep -Erh "DefaultNetstreamDriverCAFile\|tls.cacert" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null)"
   if [ -n "$l_cacert" ]; then
      l_output="$l_output\n - rsyslog TLS CA cert is configured:\n$l_cacert"
   else
      l_output2="$l_output2\n - rsyslog TLS CA cert (DefaultNetstreamDriverCAFile or tls.cacert) is not configured"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
