#!/bin/bash
# 7.1.10 Ensure no world-writable files exist

{
   l_output="" l_output2=""
   l_wwfiles="$(find / -xdev -type f -perm -0002 2>/dev/null | grep -v "^/proc\|^/sys")"
   if [ -n "$l_wwfiles" ]; then
      l_output2="$l_output2\n - World-writable files found:\n$l_wwfiles"
   else
      l_output="$l_output\n - No world-writable files found"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
