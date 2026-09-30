#!/bin/bash
# 6.2.4.1 Ensure auditd is installed and enabled

{
   l_output="" l_output2=""
   if rpm -q audit &>/dev/null; then
      l_output="$l_output\n - audit is installed: $(rpm -q audit)"
   else
      l_output2="$l_output2\n - audit is not installed"
   fi
   l_state="$(systemctl is-enabled auditd 2>/dev/null)"
   if [ "$l_state" = "enabled" ]; then
      l_output="$l_output\n - auditd.service is enabled"
   else
      l_output2="$l_output2\n - auditd.service is not enabled (state: ${l_state:-not found})"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
