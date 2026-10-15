#!/bin/bash
# RHL9-104 | Ensure rsyslog logrotate is configured
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Review \`/etc/logrotate.conf\` and \`/etc/logrotate.d/*\` and verify logs are rotated according to site policy."
   echo -e "  \`\`\`"
   echo -e "  #!/usr/bin/env bash"
   echo -e "  "
   echo -e "  { "
   echo -e "   l_output=\"\" l_rotate_conf=\"\" #check for logrotate.conf file"
   echo -e "   if [ -f /etc/logrotate.conf ]; then"
   echo -e "   l_rotate_conf=\"/etc/logrotate.conf\""
   echo -e "   elif compgen -G \"/etc/logrotate.d/*.conf\" 2>/dev/null; then"
   echo -e "   for file in /etc/logrotate.d/*.conf; do"
   echo -e "   l_rotate_conf=\"\$file\" "
   echo -e "   done"
   echo -e "   elif systemctl is-active --quiet systemd-journal-upload.service; then"
   echo -e "   echo -e \"- journald is in use on system\n - recommendation is NA\""
   echo -e "   else "
   echo -e "   echo -e \"- logrotate is not configured\""
   echo -e "   l_output=\"\$l_output\n- rsyslog is in use and logrotate is not configured\""
   echo -e "   fi"
   echo -e "   if [ -z \"\$l_output\" ]; then # Provide output from checks"
   echo -e "   echo -e \"\n- Audit Result:\n ** REVIEW **\n - \$l_rotate_conf and verify logs are rotated according to site policy.\""
   echo -e "   else"
   echo -e "   echo -e \"\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n\$l_output\""
   echo -e "   fi"
   echo -e "  }"
   echo -e "  \`\`\`"
   echo ""
}
