#!/bin/bash
# 1.6.4 Ensure SETroubleshoot is not installed

{
   l_output="" l_output2=""

   if rpm -q setroubleshoot &>/dev/null; then
      l_output2="$l_output2\n - setroubleshoot is installed: $(rpm -q setroubleshoot)"
   else
      l_output="$l_output\n - setroubleshoot is not installed"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
