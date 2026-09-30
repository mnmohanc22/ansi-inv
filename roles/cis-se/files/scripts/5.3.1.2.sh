#!/bin/bash
# 5.3.1.2 Ensure authselect is configured

{
   l_output="" l_output2=""
   l_authsel="$(authselect current 2>/dev/null)"
   if [ -n "$l_authsel" ]; then
      l_output="$l_output\n - authselect is configured:\n$l_authsel"
   else
      l_output2="$l_output2\n - authselect is not configured or returned no output"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
