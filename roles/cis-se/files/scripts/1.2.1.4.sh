#!/bin/bash
# 1.2.1.4 Ensure repo_gpgcheck is enabled for all package repositories

{
   l_output="" l_output2=""

   l_count=$(grep -rh "repo_gpgcheck" /etc/dnf/dnf.conf /etc/yum.repos.d/ 2>/dev/null | grep -v "^#" | grep -c "repo_gpgcheck=0")
   if [ "$l_count" -eq 0 ]; then
      l_output="$l_output\n - No repositories have repo_gpgcheck disabled"
   else
      l_output2="$l_output2\n - $l_count repository/configuration entries have repo_gpgcheck=0"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
