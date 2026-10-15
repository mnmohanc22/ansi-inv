#!/bin/bash
# RHL9-103 | Ensure nftables default deny firewall policy

{
   l_output="" l_output2=""

   l_result_1="$(systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook input' | grep -v 'policy drop' 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook input' | grep -v 'policy drop': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook input' | grep -v 'policy drop': ${l_result_1}"
   fi

   l_result_2="$(systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook forward' | grep -v 'policy drop' 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook forward' | grep -v 'policy drop': no output (PASS)"
   else
      l_output2="$l_output2\n - systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook forward' | grep -v 'policy drop': ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
