#!/bin/bash
# RHL9-01 | Ensure updates, patches, and additional security software are installed
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Run the following command and verify there are no updates or patches to install:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # dnf check-update"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Check to make sure no system reboot is required"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  dnf needs-restarting -r"
   echo -e "  \`\`\`"
   echo ""
}
