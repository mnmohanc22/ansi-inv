#!/bin/bash
# RHL9-117 | Ensure journald log file rotation is configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Review \`/etc/systemd/journald.conf\` and files in the \`/etc/systemd/journald.conf.d/\` directory ending in \`.conf\`. Verify logs are rotated according to site policy. "
   echo -e "  "
   echo -e "  Run the following command and ensure logs are rotated according to site policy:"
   echo -e "  \`\`\`"
   echo -e "  # systemd-analyze cat-config systemd/journald.conf | grep -E '(SystemMaxUse|SystemKeepFree|RuntimeMaxUse|RuntimeKeepFree|MaxFileSec)'"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  SystemMaxUse="
   echo -e "  SystemKeepFree="
   echo -e "  RuntimeMaxUse="
   echo -e "  RuntimeKeepFree="
   echo -e "  MaxFileSec="
   echo -e "  \`\`\`"
   echo ""
}
