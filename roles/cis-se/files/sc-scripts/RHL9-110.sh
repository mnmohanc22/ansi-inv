#!/bin/bash
# RHL9-110 | Ensure rsyslog logging is configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Review the contents of \`/etc/rsyslog.conf\` and \`/etc/rsyslog.d/*.conf\` files to ensure appropriate logging is set. In addition, run the following command and verify that the log files are logging information as expected:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # ls -l /var/log/maillog"
   echo -e "  \`\`\`"
   echo ""
}
