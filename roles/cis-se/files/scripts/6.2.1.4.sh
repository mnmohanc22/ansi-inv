#!/bin/bash
# 6.2.1.4 Ensure all log files have permissions 640 or more restrictive

{
   l_output="" l_output2=""
   l_badfiles="$(find /var/log -type f ! -path "*/journal/*" 2>/dev/null -exec stat -c "%a %n" {} \; | awk '$1>640 {print $2" (mode: "$1")"}')"
   if [ -n "$l_badfiles" ]; then
      l_output2="$l_output2\n - Log files with permissions > 640:\n$l_badfiles"
   else
      l_output="$l_output\n - All log files in /var/log have permissions <= 640"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
