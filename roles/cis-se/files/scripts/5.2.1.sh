#!/bin/bash
# 5.2.1 Ensure sudo is installed

{
   l_output="" l_output2=""
   if rpm -q sudo &>/dev/null; then
      l_output="$l_output\n - sudo is installed: $(rpm -q sudo)"
   else
      l_output2="$l_output2\n - sudo is not installed"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
