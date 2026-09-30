#!/bin/bash
# 2.1.21 Ensure MTA is configured for local-only mode

{
   l_output="" l_output2=""
   l_mta="$(ss -lntu 2>/dev/null | grep -E ':25\b')"
   if echo "$l_mta" | grep -Eq '0\.0\.0\.0:25|:::25|\*:25'; then
      l_output2="$l_output2\n - MTA is listening on non-loopback interface:\n$l_mta"
   else
      l_output="$l_output\n - MTA is only listening on loopback or not running"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
