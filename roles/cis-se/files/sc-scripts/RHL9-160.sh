#!/bin/bash
# RHL9-160 | Ensure password history remember is configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Perform an automated test using the current Nessus Profile provided by the IRS Office of Safeguards website or from a SSH session run the following command and verify that the remember option is set to \`24\` or more and meets local site policy in \`/etc/security/pwhistory.conf\`:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # grep -Pi -- '^\h*remember\h*=\h*(2[4-9]|[3-9][0-9]|[1-9][0-9]{2,})\b' /etc/security/pwhistory.conf"
   echo -e "  "
   echo -e "  remember = 24"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Perform an automated test using the current Nessus Profile provided by the IRS Office of Safeguards website or from a SSH session run the following command to verify that the remember option is not set to less than \`24\` on the \`pam_pwhistory.so\` module in \`/etc/pam.d/password-auth\` and \`/etc/pam.d/system-auth\`:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # grep -Pi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?remember=(2[0-3]|1[0-9]|[0-9])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth"
   echo -e "  "
   echo -e "  Nothing should be returned"
   echo -e "  \`\`\`"
   echo ""
}
