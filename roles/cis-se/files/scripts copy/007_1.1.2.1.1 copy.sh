#!/bin/bash

{
   l_output="" l_output2=""

   if findmnt -nk /tmp | grep -Pq '\bnodev\b'; then
      l_output="$l_output\n - nodev option is set on /tmp"
   else
      l_output2="$l_output2\n - nodev option is not set on /tmp"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
