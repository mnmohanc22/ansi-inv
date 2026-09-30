#!/bin/bash
# 4.2.2 Ensure chronyd is run as the chrony user

{
   l_output="" l_output2=""
   if [ -f /etc/sysconfig/chronyd ]; then
      if grep -q "\-u chrony" /etc/sysconfig/chronyd 2>/dev/null; then
         l_output="$l_output\n - chronyd is configured to run as chrony user in /etc/sysconfig/chronyd"
      else
         l_output2="$l_output2\n - '-u chrony' not found in /etc/sysconfig/chronyd"
      fi
   else
      l_output2="$l_output2\n - /etc/sysconfig/chronyd does not exist"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
