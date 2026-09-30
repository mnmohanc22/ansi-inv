#!/bin/bash
# 1.5.4 Ensure user namespaces are disabled

{
   l_output="" l_output2=""

   l_val=$(sysctl user.max_user_namespaces 2>/dev/null | awk '{print $3}')
   if [ "$l_val" = "0" ]; then
      l_output="$l_output\n - user.max_user_namespaces = $l_val (PASS)"
   else
      l_output2="$l_output2\n - user.max_user_namespaces = $l_val (should be 0)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
