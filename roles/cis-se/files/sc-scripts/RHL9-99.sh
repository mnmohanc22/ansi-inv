#!/bin/bash
# RHL9-99 | Ensure nftables base chains exist

{
   l_output="" l_output2=""

   l_result_1="$(nft list ruleset | grep 'hook input' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - nft list ruleset | grep 'hook input': no output (PASS)"
   else
      l_output2="$l_output2\n - nft list ruleset | grep 'hook input': ${l_result_1}"
   fi

   l_result_2="$(type filter hook input 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - type filter hook input: no output (PASS)"
   else
      l_output2="$l_output2\n - type filter hook input: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
