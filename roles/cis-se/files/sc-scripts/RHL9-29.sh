#!/bin/bash
# RHL9-29 | Ensure filesystem integrity is regularly checked

{
   l_output="" l_output2=""

   l_result_1="$(grep -Ers '^([^#]+\s+)?(\/usr\/s?bin\/|^\s*)aide(\.wrapper)?\s(--?\S+\s)*(--(check|update)|\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/ 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Ers '^([^#]+\s+)?(\/usr\/s?bin\/|^\s*)aide(\.wrapper)?\s(--?\S+\s)*(--(check|update)|\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Ers '^([^#]+\s+)?(\/usr\/s?bin\/|^\s*)aide(\.wrapper)?\s(--?\S+\s)*(--(check|update)|\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/: ${l_result_1}"
   fi

   l_result_2="$(systemctl is-enabled aidecheck.service 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - systemctl is-enabled aidecheck.service: no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-enabled aidecheck.service: ${l_result_2}"
   fi

   l_result_3="$(systemctl is-enabled aidecheck.timer 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - systemctl is-enabled aidecheck.timer: no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl is-enabled aidecheck.timer: ${l_result_3}"
   fi

   l_result_4="$(systemctl status aidecheck.timer 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - systemctl status aidecheck.timer: no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl status aidecheck.timer: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
