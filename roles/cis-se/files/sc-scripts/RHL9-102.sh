#!/bin/bash
# RHL9-102 | Ensure nftables established connections are configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  If \`NFTables\` utility is in use on your system:"
   echo -e "  "
   echo -e "  Run the following commands and verify all rules for established incoming connections match site policy:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # systemctl is-enabled nftables.service | grep -q 'enabled' && nft list ruleset | awk '/hook input/,/}/' | grep 'ct state'"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Output should be similar to:"
   echo -e "  \`\`\`"
   echo -e "  ip protocol tcp ct state established accept"
   echo -e "  ip protocol udp ct state established accept"
   echo -e "  ip protocol icmp ct state established accept"
   echo -e "  \`\`\`"
   echo ""
}
