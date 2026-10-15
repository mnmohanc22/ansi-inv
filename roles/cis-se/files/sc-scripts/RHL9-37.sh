#!/bin/bash
# RHL9-37 | Ensure SELinux is not disabled in bootloader configuration

{
   l_output="" l_output2=""

   l_result_1="$(grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b': no output (PASS)"
   else
      l_output2="$l_output2\n - grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b': ${l_result_1}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
