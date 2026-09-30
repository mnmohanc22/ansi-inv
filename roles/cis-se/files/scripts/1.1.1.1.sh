#!/bin/bash
# 1.1.1.1 Ensure mounting of cramfs filesystems is disabled

{
   l_output="" l_output2=""

   l_mod="cramfs"
   if modprobe -n -v "$l_mod" 2>&1 | grep -Pq "^\s*install\s+/bin/(true|false)"; then
      l_output="$l_output\n - $l_mod module is not available"
   elif ! lsmod | grep -q "^${l_mod}\b"; then
      l_output="$l_output\n - $l_mod module is not loaded"
   else
      l_output2="$l_output2\n - $l_mod module is loaded"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
