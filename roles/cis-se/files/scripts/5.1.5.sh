#!/bin/bash
# 5.1.5 Ensure SSH LogLevel is set to VERBOSE or INFO

{
   l_output="" l_output2=""
   l_loglevel="$(sshd -T 2>/dev/null | grep -i "^loglevel" | awk '{print $2}' | tr '[:lower:]' '[:upper:]')"
   if [ "$l_loglevel" = "VERBOSE" ] || [ "$l_loglevel" = "INFO" ]; then
      l_output="$l_output\n - SSH LogLevel is set to $l_loglevel"
   else
      l_output2="$l_output2\n - SSH LogLevel is set to '${l_loglevel:-not set}' (expected VERBOSE or INFO)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
