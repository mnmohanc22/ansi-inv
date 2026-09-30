#!/bin/bash
# 2.1.19 Ensure xinetd is not enabled

{
   l_output="" l_output2=""
   if rpm -q xinetd &>/dev/null; then
      l_state="$(systemctl is-enabled xinetd 2>/dev/null)"
      if [ "$l_state" = "enabled" ]; then
         l_output2="$l_output2\n - xinetd is installed and enabled"
      else
         l_output2="$l_output2\n - xinetd is installed (state: $l_state)"
      fi
   else
      l_output="$l_output\n - xinetd is not installed"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
