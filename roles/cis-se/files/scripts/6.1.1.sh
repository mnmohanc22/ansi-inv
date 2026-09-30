#!/bin/bash
# 6.1.1 Ensure no packages have modified permissions

{
   l_output="" l_output2=""
   l_modified="$(rpm -Va --noconfig 2>/dev/null | grep "^.M")"
   if [ -n "$l_modified" ]; then
      l_output2="$l_output2\n - Packages with modified file permissions found:\n$l_modified"
   else
      l_output="$l_output\n - No packages with modified file permissions found"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
