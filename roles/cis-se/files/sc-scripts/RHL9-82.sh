#!/bin/bash
# RHL9-82 | Ensure IPv6 status is identified
# Test Method: Manual

{
   echo -e "\n- Audit Result:\n  ** MANUAL REVIEW REQUIRED **"
   echo -e "\n- Test Procedure:"
   echo -e "  Run the following script to identify if IPv6 is enabled on the system:"
   echo -e "  "
   echo -e "  \`\`\`"
   echo -e "  #!/usr/bin/env bash"
   echo -e "  "
   echo -e "  {"
   echo -e "   l_output=\"\""
   echo -e "   ! grep -Pqs -- '^\h*0\b' /sys/module/ipv6/parameters/disable && l_output=\"- IPv6 is not enabled\""
   echo -e "   if sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- \"^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\b\" && \"
   echo -e "   sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- \"^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\b\"; then"
   echo -e "   l_output=\"- IPv6 is not enabled\""
   echo -e "   fi"
   echo -e "   [ -z \"\$l_output\" ] && l_output=\"- IPv6 is enabled\""
   echo -e "   echo -e \"\n\$l_output\n\""
   echo -e "  }"
   echo -e "  \`\`\`"
   echo ""
}
