#!/bin/bash
# 7.2.2 Ensure all GIDs in /etc/passwd exist in /etc/group

{
   l_output="" l_output2=""
   while IFS=: read -r l_user l_pass l_uid l_gid l_comment l_home l_shell; do
      if ! awk -F: '{print $3}' /etc/group 2>/dev/null | grep -qx "$l_gid"; then
         l_output2="$l_output2\n - $l_user has GID $l_gid which does not exist in /etc/group"
      else
         l_output="$l_output\n - $l_user: GID $l_gid exists in /etc/group"
      fi
   done < /etc/passwd
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
