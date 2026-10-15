#!/bin/bash
# RHL9-101 | Ensure firewalld drops unnecessary services and ports
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Run the following command and review output to ensure that listed services and ports follow site policy. "
   echo -e "  \`\`\`"
   echo -e "  # systemctl is-enabled firewalld.service | grep -q 'enabled' && firewall-cmd --list-all --zone=\"\$(firewall-cmd --list-all | awk '/\(active\)/ { print \$1 }')\" | grep -P -- '^\h*(services:|ports:)'"
   echo -e "  \`\`\`"
   echo ""
}
