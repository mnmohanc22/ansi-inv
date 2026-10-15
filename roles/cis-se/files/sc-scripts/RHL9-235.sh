#!/bin/bash
# RHL9-235 | Ensure password same consecutive characters is configured

{
   l_output="" l_output2=""

   l_result_1="$(grep -Psi -- '^\h*maxrepeat\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*maxrepeat\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*maxrepeat\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf: ${l_result_1}"
   fi

   l_result_2="$(/etc/security/pwquality.conf.d/50-pwrepeat.conf:maxrepeat = 3 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - /etc/security/pwquality.conf.d/50-pwrepeat.conf:maxrepeat = 3: no output (PASS)"
   else
      l_output2="$l_output2\n - /etc/security/pwquality.conf.d/50-pwrepeat.conf:maxrepeat = 3: ${l_result_2}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
