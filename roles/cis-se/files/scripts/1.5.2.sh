#!/bin/bash
# 1.5.2 Ensure ptrace_scope is restricted

{
   l_output="" l_output2=""

   l_val=$(sysctl kernel.yama.ptrace_scope 2>/dev/null | awk '{print $3}')
   if [ -n "$l_val" ] && [ "$l_val" -ge 1 ] 2>/dev/null; then
      l_output="$l_output\n - kernel.yama.ptrace_scope = $l_val (>= 1, acceptable)"
   else
      l_output2="$l_output2\n - kernel.yama.ptrace_scope = $l_val (should be >= 1)"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
