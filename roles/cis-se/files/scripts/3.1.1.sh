#!/bin/bash
# 3.1.1 Ensure IPv6 status is identified

{
   if grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable; then
      l_state="enabled"
   else
      l_state="disabled"
   fi

   echo -e "\n- Audit Result:\n  ** PASS **\n - IPv6 is ${l_state}\n"
}
