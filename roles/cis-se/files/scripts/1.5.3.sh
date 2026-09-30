#!/bin/bash
# 1.5.3 Ensure kexec is disabled

{
   l_output="" l_output2=""

   l_val=$(sysctl kernel.kexec_load_disabled 2>/dev/null | awk '{print $3}')
   if [ "$l_val" = "1" ]; then
      l_output="$l_output\n - kernel.kexec_load_disabled = $l_val (PASS)"
   else
      l_output2="$l_output2\n - kernel.kexec_load_disabled = $l_val (should be 1)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
