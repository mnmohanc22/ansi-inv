#!/bin/bash
# 7.1.9 Ensure world-writable directories have the sticky bit set

{
   l_output="" l_output2=""
   l_ww_nosticky="$(find / -xdev -type d -perm -0002 ! -perm -1000 2>/dev/null | grep -v "^/proc\|^/sys")"
   if [ -n "$l_ww_nosticky" ]; then
      l_output2="$l_output2\n - World-writable directories without sticky bit:\n$l_ww_nosticky"
   else
      l_output="$l_output\n - All world-writable directories have the sticky bit set"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
