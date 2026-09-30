#!/bin/bash
# 5.4.2.1 Ensure root's default group is GID 0

{
   l_output="" l_output2=""
   l_gid="$(grep "^root:" /etc/passwd | cut -d: -f4)"
   if [ "$l_gid" = "0" ]; then
      l_output="$l_output\n - root default group GID is 0"
   else
      l_output2="$l_output2\n - root default group GID is ${l_gid:-not found} (expected 0)"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
