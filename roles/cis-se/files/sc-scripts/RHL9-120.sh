#!/bin/bash
# RHL9-120 | Ensure systemd-journal-upload authentication is configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Run the following command to verify \`systemd-journal-upload\` authentication is configured:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  # grep -P \"^ *URL=|^ *ServerKeyFile=|^ *ServerCertificateFile=|^ *TrustedCertificateFile=\" /etc/systemd/journal-upload.conf"
   echo -e "  \`\`\`"
   echo -e "  "
   echo -e "  Verify the output matches per your environments certificate locations and the URL of the log server:"
   echo -e "  "
   echo -e "  _Example:_"
   echo -e "  \`\`\`"
   echo -e "  [Upload]"
   echo -e "  URL=192.168.50.42"
   echo -e "  ServerKeyFile=/etc/ssl/private/journal-upload.pem"
   echo -e "  ServerCertificateFile=/etc/ssl/certs/journal-upload.pem"
   echo -e "  TrustedCertificateFile=/etc/ssl/ca/trusted.pem"
   echo -e "  \`\`\`"
   echo ""
}
