#!/bin/bash
# 1.6.7 Ensure the MCS Translation Service (mcstrans) is not installed

{
   l_output="" l_output2=""

   if rpm -q mcstrans &>/dev/null; then
      l_output2="$l_output2\n - mcstrans is installed: $(rpm -q mcstrans)"
   else
      l_output="$l_output\n - mcstrans is not installed"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
