#!/bin/bash
# 7.2.9 Ensure users own their home directories

{
   l_output="" l_output2=""
   while IFS=: read -r l_user l_pass l_uid l_gid l_comment l_home l_shell; do
      if [ "$l_uid" -ge 1000 ] && [ "$l_user" != "nfsnobody" ] 2>/dev/null; then
         if [ -d "$l_home" ]; then
            l_dir_owner="$(stat -c "%U" "$l_home" 2>/dev/null)"
            if [ "$l_dir_owner" = "$l_user" ]; then
               l_output="$l_output\n - $l_user owns $l_home"
            else
               l_output2="$l_output2\n - $l_user does not own $l_home (owner: $l_dir_owner)"
            fi
         else
            l_output2="$l_output2\n - $l_user: home directory $l_home does not exist"
         fi
      fi
   done < /etc/passwd
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
