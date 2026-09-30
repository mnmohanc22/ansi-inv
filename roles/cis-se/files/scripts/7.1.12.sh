#!/bin/bash
# 7.1.12 Ensure no ungrouped files or directories exist

{
   l_output="" l_output2=""
   l_ungrouped="$(find / -xdev -nogroup 2>/dev/null | grep -v "^/proc\|^/sys")"
   if [ -n "$l_ungrouped" ]; then
      l_output2="$l_output2\n - Ungrouped files/directories found:\n$l_ungrouped"
   else
      l_output="$l_output\n - No ungrouped files or directories found"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
