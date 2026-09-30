#!/bin/bash
# 1.3.1.1 Ensure AIDE is installed

{
   l_output="" l_output2=""

   if rpm -q aide &>/dev/null; then
      l_output="$l_output\n - aide is installed ($(rpm -q aide 2>/dev/null))"
   else
      l_output2="$l_output2\n - aide is not installed"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
