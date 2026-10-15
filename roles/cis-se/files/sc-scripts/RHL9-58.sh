#!/bin/bash
# RHL9-58 | Ensure only approved services are listening on a network interface
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  From a SSH session run the following command:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # ss -plntu"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Review the output to ensure:"
   echo -e "  - All services listed are required on the system and approved by local site policy. "
   echo -e "  - Both the port and interface the service is listening on are approved by local site policy."
   echo -e "  - If a listed service is not required:"
   echo -e "   - Remove the package containing the service"
   echo -e "   - If the service's package is required for a dependency, stop and mask the service and/or socket"
   echo ""
}
