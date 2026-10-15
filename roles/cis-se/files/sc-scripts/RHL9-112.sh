#!/bin/bash
# RHL9-112 | Ensure rsyslog is not configured to receive logs from a remote client

{
   l_output="" l_output2=""

   l_result_1="$(grep -Psi -- '^\h*module\(load=\"?imtcp\"?\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*module\(load=\"?imtcp\"?\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*module\(load=\"?imtcp\"?\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: ${l_result_1}"
   fi

   l_result_2="$(grep -Psi -- '^\h*input\(type=\"?imtcp\"?\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*input\(type=\"?imtcp\"?\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*input\(type=\"?imtcp\"?\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: ${l_result_2}"
   fi

   l_result_3="$(grep -Psi -- '^\h*\$ModLoad\h+imtcp\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*\$ModLoad\h+imtcp\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*\$ModLoad\h+imtcp\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: ${l_result_3}"
   fi

   l_result_4="$(grep -Psi -- '^\h*\$InputTCPServerRun\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - grep -Psi -- '^\h*\$InputTCPServerRun\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: no output (PASS)"
   else
      l_output2="$l_output2\n - grep -Psi -- '^\h*\$InputTCPServerRun\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf: ${l_result_4}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
