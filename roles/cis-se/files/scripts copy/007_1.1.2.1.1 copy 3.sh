#!/bin/bash

{
   l_output="" l_output2=""

   l_findmnt_out="$(findmnt -nk /var 2>/dev/null)"
   if [ -n "$l_findmnt_out" ]; then
      l_output="$l_output\n - /var is a separate partition:\n$l_findmnt_out"

      if echo "$l_findmnt_out" | grep -Pq '\bnosuid\b'; then
         l_output="$l_output\n - nosuid option is set on /var"
      else
         l_output2="$l_output2\n - nosuid option is not set on /var"
      fi
   else
      l_output2="$l_output2\n - /var is not mounted as a separate partition"
   fi

   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
