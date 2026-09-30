#!/bin/bash
# 6.2.1.3 Ensure rsyslog default file permissions are configured

{
   l_output="" l_output2=""
   l_line="$(grep -Erh "^\\\$FileCreateMode" /etc/rsyslog.conf /etc/rsyslog.d/ 2>/dev/null | tail -1)"
   if [ -n "$l_line" ]; then
      l_val="$(echo "$l_line" | awk '{print $2}' | tr -d ' ')"
      l_num="$(printf '%d' "0$l_val" 2>/dev/null)"
      if [ "$l_num" -le "$(printf '%d' "0640")" ] 2>/dev/null; then
         l_output="$l_output\n - \$FileCreateMode is set to $l_val (acceptable: <= 0640)"
      else
         l_output2="$l_output2\n - \$FileCreateMode is set to $l_val (expected <= 0640)"
      fi
   else
      l_output2="$l_output2\n - \$FileCreateMode is not configured in rsyslog.conf or rsyslog.d/"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
