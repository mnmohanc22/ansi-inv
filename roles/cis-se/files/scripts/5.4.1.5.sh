#!/bin/bash
# 5.4.1.5 Ensure no accounts have future password change dates

{
   l_output="" l_output2=""
   l_today="$(date +%s)"
   l_today_days=$(( l_today / 86400 ))
   while IFS=: read -r l_user l_chage; do
      if [ -n "$l_chage" ] && [ "$l_chage" -gt "$l_today_days" ] 2>/dev/null; then
         l_output2="$l_output2\n - $l_user has a future last password change date (days: $l_chage)"
      fi
   done < <(awk -F: '($2~/^\$/) {print $1":"$3}' /etc/shadow 2>/dev/null)
   if [ -z "$l_output2" ]; then
      l_output="$l_output\n - No accounts have future password change dates"
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
