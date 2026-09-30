#!/bin/bash
# 5.4.2.4 Ensure no + entries exist in /etc/passwd

{
   l_output="" l_output2=""
   l_count="$(grep -c "^+" /etc/passwd 2>/dev/null)"
   if [ "$l_count" -eq 0 ] 2>/dev/null; then
      l_output="$l_output\n - No '+' entries in /etc/passwd"
   else
      l_output2="$l_output2\n - Found $l_count '+' entr(ies) in /etc/passwd"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
