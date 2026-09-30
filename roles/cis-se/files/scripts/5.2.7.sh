#!/bin/bash
# 5.2.7 Ensure sudo timestamp_timeout is configured

{
   l_output="" l_output2=""
   l_timeout="$(grep -rh "^Defaults.*timestamp_timeout" /etc/sudoers /etc/sudoers.d/ 2>/dev/null)"
   if [ -n "$l_timeout" ]; then
      l_tval="$(echo "$l_timeout" | grep -Eo 'timestamp_timeout\s*=\s*[0-9]+' | grep -Eo '[0-9]+')"
      if [ -n "$l_tval" ] && [ "$l_tval" -le 15 ] 2>/dev/null; then
         l_output="$l_output\n - timestamp_timeout is set to $l_tval (acceptable: <= 15)"
      else
         l_output2="$l_output2\n - timestamp_timeout value is '${l_tval:-not parsed}' (expected <= 15): $l_timeout"
      fi
   else
      l_output2="$l_output2\n - timestamp_timeout is not configured in sudoers"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
