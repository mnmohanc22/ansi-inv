#!/bin/bash
# 1.8.10 Ensure XDCMP is not enabled

{
   l_output="" l_output2=""

   if rpm -q gdm &>/dev/null; then
      if grep -Pih "^\s*Enable\s*=\s*true" /etc/gdm/custom.conf 2>/dev/null | grep -qi "true"; then
         l_output2="$l_output2\n - XDMCP is enabled in /etc/gdm/custom.conf"
      else
         l_output="$l_output\n - XDMCP is not enabled"
      fi
   else
      l_output="$l_output\n - GDM is not installed - not applicable"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
