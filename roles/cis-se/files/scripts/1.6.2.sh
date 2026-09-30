#!/bin/bash
# 1.6.2 Ensure SELinux is in enforcing mode

{
   l_output="" l_output2=""

   l_selinux=$(getenforce 2>/dev/null)
   if [ "$l_selinux" = "Enforcing" ]; then
      l_output="$l_output\n - SELinux is in Enforcing mode"
   else
      l_output2="$l_output2\n - SELinux is in '$l_selinux' mode (should be Enforcing)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
