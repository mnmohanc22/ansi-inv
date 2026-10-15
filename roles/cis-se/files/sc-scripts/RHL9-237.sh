#!/bin/bash
# RHL9-237 | Ensure password dictionary check is enabled

{
   l_output="" l_output2=""

   l_result_1="$(grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf: ${l_result_1}"
   fi

   l_result_2="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_2}"
   fi

   l_result_3="$(grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/system-auth /etc/pam.d/password-auth 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/system-auth /etc/pam.d/password-auth: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/system-auth /etc/pam.d/password-auth: ${l_result_3}"
   fi

   l_result_4="$(Nothing should be returned 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - Nothing should be returned: no output (PASS)"
   else
      l_output2="$l_output2\n - Nothing should be returned: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
