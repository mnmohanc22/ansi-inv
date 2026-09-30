#!/bin/bash
# 3.3.5 Ensure source routed packets are not accepted

{
   l_output="" l_output2=""
   l_val="$(sysctl net.ipv4.conf.all.accept_source_route 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')"
   if [ "$l_val" = "0" ]; then
      l_output="$l_output\n - net.ipv4.conf.all.accept_source_route = $l_val"
   else
      l_output2="$l_output2\n - net.ipv4.conf.all.accept_source_route = ${l_val:-not set} (expected 0)"
   fi
   l_val="$(sysctl net.ipv4.conf.default.accept_source_route 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')"
   if [ "$l_val" = "0" ]; then
      l_output="$l_output\n - net.ipv4.conf.default.accept_source_route = $l_val"
   else
      l_output2="$l_output2\n - net.ipv4.conf.default.accept_source_route = ${l_val:-not set} (expected 0)"
   fi
   l_val="$(sysctl net.ipv6.conf.all.accept_source_route 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')"
   if [ "$l_val" = "0" ]; then
      l_output="$l_output\n - net.ipv6.conf.all.accept_source_route = $l_val"
   else
      l_output2="$l_output2\n - net.ipv6.conf.all.accept_source_route = ${l_val:-not set} (expected 0)"
   fi
   l_val="$(sysctl net.ipv6.conf.default.accept_source_route 2>/dev/null | awk -F= '{print $2}' | tr -d ' ')"
   if [ "$l_val" = "0" ]; then
      l_output="$l_output\n - net.ipv6.conf.default.accept_source_route = $l_val"
   else
      l_output2="$l_output2\n - net.ipv6.conf.default.accept_source_route = ${l_val:-not set} (expected 0)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
