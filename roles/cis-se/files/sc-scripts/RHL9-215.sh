#!/bin/bash
# RHL9-215 | Ensure system wide crypto policy disables EtM for ssh
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  If \`CVE-2023-48795\` has been addressed or if CBC is disabled for OpenSSH server this recommendation is not needed."
   echo -e "  "
   echo -e "  Run the following command to verify \`EtM\` is disabled for \`SSH\`:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # grep -Psi -- '^\h*etm\b' /etc/crypto-policies/state/CURRENT.pol"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Verify output includes either:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  etm@libssh = DISABLE_ETM"
   echo -e "  etm@openssh-client = DISABLE_ETM"
   echo -e "  etm@openssh-server = DISABLE_ETM"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  **- OR -**"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  etm = DISABLE_ETM"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  **Note:** The ability to disable EtM through system wide crypto policy was added in version 9.3"
   echo ""
}
