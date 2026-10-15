#!/bin/bash
# RHL9-143 | Ensure system wide crypto policy is not set in sshd configuration

{
   l_output="" l_output2=""

   l_result_1="$(grep -Pi '^\h*CRYPTO_POLICY\h*=' /etc/sysconfig/sshd 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Pi '^\h*CRYPTO_POLICY\h*=' /etc/sysconfig/sshd: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Pi '^\h*CRYPTO_POLICY\h*=' /etc/sysconfig/sshd: ${l_result_1}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
