#!/bin/bash
# 5.3.2.5 Ensure faillock even_deny_root is configured

{
   l_output="" l_output2=""
   l_line="$(grep -E "^\s*even_deny_root" /etc/security/faillock.conf 2>/dev/null)"
   if [ -n "$l_line" ]; then
      l_output="$l_output\n - even_deny_root is configured in /etc/security/faillock.conf: $l_line"
   else
      l_output2="$l_output2\n - even_deny_root is not configured in /etc/security/faillock.conf"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
