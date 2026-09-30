#!/bin/bash
# 6.2.2.2 Ensure rsyslog log rotation is configured

{
   l_output="" l_output2=""
   if [ -f /etc/logrotate.d/rsyslog ]; then
      l_output="$l_output\n - /etc/logrotate.d/rsyslog exists"
   else
      l_rotatecfg="$(grep -rh "rsyslog\|syslog" /etc/logrotate.conf /etc/logrotate.d/ 2>/dev/null | grep -v "^#")"
      if [ -n "$l_rotatecfg" ]; then
         l_output="$l_output\n - rsyslog/syslog log rotation reference found in logrotate config"
      else
         l_output2="$l_output2\n - No rsyslog log rotation configuration found"
      fi
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
