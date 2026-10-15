#!/bin/bash
# RHL9-167 | Ensure password expiration is configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Perform an automated test using the current Nessus Profile provided by the IRS Office of Safeguards website or from a SSH session run the following command and verify \`PASS_MAX_DAYS\` is set to 90 days or less and conforms to local site policy:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # grep -Pi -- '^\h*PASS_MAX_DAYS\h+\d+\b' /etc/login.defs"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  _Example output:_"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  PASS_MAX_DAYS 90"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Perform an automated test using the current Nessus Profile provided by the IRS Office of Safeguards website or from a SSH session run the following command to verify all \`/etc/shadow\` passwords \`PASS_MAX_DAYS\`:"
   echo -e "  - is greater than \`0\` days"
   echo -e "  - is less than or equal to \`90\` days"
   echo -e "  - conforms to local site policy"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # awk -F: '(\$2~/^\\$.+\\$/) {if(\$5 > 90|| \$5 < 1)print \"User: \" \$1 \" PASS_MAX_DAYS: \" \$5}' /etc/shadow"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Nothing should be returned"
   echo ""
}
