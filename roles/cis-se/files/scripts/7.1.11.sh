#!/bin/bash
# 7.1.11 Ensure no unowned files or directories exist

{
   l_output="" l_output2=""
   l_unowned="$(find / -xdev -nouser 2>/dev/null | grep -v "^/proc\|^/sys")"
   if [ -n "$l_unowned" ]; then
      l_output2="$l_output2\n - Unowned files/directories found:\n$l_unowned"
   else
      l_output="$l_output\n - No unowned files or directories found"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
