#!/bin/bash
# 1.7.1 Ensure message of the day is configured properly

{
   l_output="" l_output2=""

   if [ -s /etc/motd ]; then
      if grep -Piq '(\\v|\\r|\\m|\\s|'"$(grep '^ID=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')"')' /etc/motd 2>/dev/null; then
         l_output2="$l_output2\n - /etc/motd contains OS-identifying information"
      else
         l_output="$l_output\n - /etc/motd exists and contains no OS-identifying information"
      fi
   else
      l_output2="$l_output2\n - /etc/motd is empty or does not exist"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
