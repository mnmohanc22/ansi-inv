#!/bin/bash
# RHL9-27 | Ensure package manager repositories are configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Run the following command to verify repositories are configured correctly. The output may vary depending on which repositories are currently configured on the system."
   echo -e "  "
   echo -e "  _Example:_"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # dnf repolist"
   echo -e "  Last metadata expiration check: 1:00:00 ago on Mon 1 Jan 2021 00:00:00 BST."
   echo -e "  repo id repo name status"
   echo -e "  *fedora Fedora 28 - x86_64 57,327"
   echo -e "  *updates Fedora 28 - x86_64 - Updates 22,133"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  For the repositories in use, inspect the configuration file to ensure all settings are correctly applied according to site policy."
   echo -e "  "
   echo -e "  _Example:_"
   echo -e "  "
   echo -e "  Depending on the distribution being used the repo file name might differ."
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  cat /etc/yum.repos.d/*.repo"
   echo -e "  "
   echo -e "  \`\`\`"
   echo ""
}
