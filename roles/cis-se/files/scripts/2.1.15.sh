#!/bin/bash
# 2.1.15 Ensure telnet-server is not installed

{
   l_output="" l_output2=""
   if rpm -q telnet-server &>/dev/null; then
      l_output2="$l_output2\n - telnet-server is installed: $(rpm -q telnet-server)"
   else
      l_output="$l_output\n - telnet-server is not installed"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
