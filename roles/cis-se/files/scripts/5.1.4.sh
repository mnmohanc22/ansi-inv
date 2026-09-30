#!/bin/bash
# 5.1.4 Ensure SSH public host key files have permissions 644 and are owned by root

{
   l_output="" l_output2=""
   while IFS= read -r l_file; do
      read -r l_mode l_owner l_group <<< "$(stat -c "%a %U %G" "$l_file")"
      if [ "$l_mode" = "644" ] && [ "$l_owner" = "root" ]; then
         l_output="$l_output\n - $l_file: mode=$l_mode owner=$l_owner group=$l_group"
      else
         [ "$l_mode" != "644" ] && l_output2="$l_output2\n - $l_file has mode $l_mode (expected 644)"
         [ "$l_owner" != "root" ] && l_output2="$l_output2\n - $l_file is owned by $l_owner (expected root)"
      fi
   done < <(find /etc/ssh -name "ssh_host_*_key.pub" 2>/dev/null)
   if [ -z "$l_output" ] && [ -z "$l_output2" ]; then
      l_output="$l_output\n - No SSH public host key files found"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
