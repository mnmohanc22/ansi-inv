#!/bin/bash
# 7.2.1 Ensure all local users have a valid shell listed in /etc/shells

{
   l_output="" l_output2=""
   l_valid_shells="$(grep -v "^#" /etc/shells 2>/dev/null)"
   while IFS=: read -r l_user l_pass l_uid l_gid l_comment l_home l_shell; do
      if [ -n "$l_shell" ]; then
         if echo "$l_valid_shells" | grep -qx "$l_shell" || [[ "$l_shell" =~ nologin|false ]]; then
            l_output="$l_output\n - $l_user: shell $l_shell is valid"
         else
            l_output2="$l_output2\n - $l_user: shell $l_shell is not listed in /etc/shells"
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
