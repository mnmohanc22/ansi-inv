#!/bin/bash
# RHL9-165 | Ensure default user umask is configured

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_output="" l_output2="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_output="" l_output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="": ${l_result_2}"
   fi

   l_result_3="$(file_umask_chk() 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - file_umask_chk(): no output (PASS)"
   else
      l_output2="$l_output2\n - file_umask_chk(): ${l_result_3}"
   fi

   l_result_4="$(if grep -Psiq -- '^\h*umask\h+(0?[0-7][2-7]7|u(=[rwx]{0,3}),g=([rx]{0,2}),o=)(\h*#.*)?$' "$l_file"; then 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - if grep -Psiq -- '^\h*umask\h+(0?[0-7][2-7]7|u(=[rwx]{0,3}),g=([rx]{0,2}),o=)(\h*#.*)?$' "$l_file"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Psiq -- '^\h*umask\h+(0?[0-7][2-7]7|u(=[rwx]{0,3}),g=([rx]{0,2}),o=)(\h*#.*)?$' "$l_file"; then: ${l_result_4}"
   fi

   l_result_5="$(l_output="$l_output\n - umask is set correctly in \"$l_file\"" 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - umask is set correctly in \"$l_file\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - umask is set correctly in \"$l_file\"": ${l_result_5}"
   fi

   l_result_6="$(elif grep -Psiq -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' "$l_file"; then 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - elif grep -Psiq -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' "$l_file"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif grep -Psiq -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' "$l_file"; then: ${l_result_6}"
   fi

   l_result_7="$(l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\"" 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\"": ${l_result_7}"
   fi

   l_result_8="$(while IFS= read -r -d $'\0' l_file; do 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - while IFS= read -r -d $'\0' l_file; do: no output (PASS)"
   else
      l_output2="$l_output2\n - while IFS= read -r -d $'\0' l_file; do: ${l_result_8}"
   fi

   l_result_9="$(file_umask_chk 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - file_umask_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - file_umask_chk: ${l_result_9}"
   fi

   l_result_10="$(done < <(find /etc/profile.d/ -type f -name '*.sh' -print0) 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - done < <(find /etc/profile.d/ -type f -name '*.sh' -print0): no output (PASS)"
   else
      l_output2="$l_output2\n - done < <(find /etc/profile.d/ -type f -name '*.sh' -print0): ${l_result_10}"
   fi

   l_result_11="$([ -z "$l_output" ] && l_file="/etc/profile" && file_umask_chk 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_file="/etc/profile" && file_umask_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_file="/etc/profile" && file_umask_chk: ${l_result_11}"
   fi

   l_result_12="$([ -z "$l_output" ] && l_file="/etc/bashrc" && file_umask_chk 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_file="/etc/bashrc" && file_umask_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_file="/etc/bashrc" && file_umask_chk: ${l_result_12}"
   fi

   l_result_13="$([ -z "$l_output" ] && l_file="/etc/bash.bashrc" && file_umask_chk 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_file="/etc/bash.bashrc" && file_umask_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_file="/etc/bash.bashrc" && file_umask_chk: ${l_result_13}"
   fi

   l_result_14="$([ -z "$l_output" ] && l_file="/etc/pam.d/postlogin" 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_file="/etc/pam.d/postlogin": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_file="/etc/pam.d/postlogin": ${l_result_14}"
   fi

   l_result_15="$(if [ -z "$l_output" ]; then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if [ -z "$l_output" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output" ]; then: ${l_result_15}"
   fi

   l_result_16="$(if grep -Psiq -- '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(0?[0-7][2-7]7)\b' "$l_file"; then 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - if grep -Psiq -- '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(0?[0-7][2-7]7)\b' "$l_file"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Psiq -- '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(0?[0-7][2-7]7)\b' "$l_file"; then: ${l_result_16}"
   fi

   l_result_17="$(l_output1="$l_output1\n - umask is set correctly in \"$l_file\"" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_output1="$l_output1\n - umask is set correctly in \"$l_file\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output1="$l_output1\n - umask is set correctly in \"$l_file\"": ${l_result_17}"
   fi

   l_result_18="$(elif grep -Psiq '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b))' "$l_file"; then 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - elif grep -Psiq '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b))' "$l_file"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif grep -Psiq '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b))' "$l_file"; then: ${l_result_18}"
   fi

   l_result_19="$(l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\"" 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\"": ${l_result_19}"
   fi

   l_result_20="$([ -z "$l_output" ] && l_file="/etc/login.defs" && file_umask_chk 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_file="/etc/login.defs" && file_umask_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_file="/etc/login.defs" && file_umask_chk: ${l_result_20}"
   fi

   l_result_21="$([ -z "$l_output" ] && l_file="/etc/default/login" && file_umask_chk 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - [ -z "$l_output" ] && l_file="/etc/default/login" && file_umask_chk: no output (PASS)"
   else
      l_output2="$l_output2\n - [ -z "$l_output" ] && l_file="/etc/default/login" && file_umask_chk: ${l_result_21}"
   fi

   l_result_22="$([[ -z "$l_output" && -z "$l_output2" ]] && l_output2="$l_output2\n - umask is not set" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - [[ -z "$l_output" && -z "$l_output2" ]] && l_output2="$l_output2\n - umask is not set": no output (PASS)"
   else
      l_output2="$l_output2\n - [[ -z "$l_output" && -z "$l_output2" ]] && l_output2="$l_output2\n - umask is not set": ${l_result_22}"
   fi

   l_result_23="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_23}"
   fi

   l_result_24="$(echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n": ${l_result_24}"
   fi

   l_result_25="$(else 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_25}"
   fi

   l_result_26="$(echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2": ${l_result_26}"
   fi

   l_result_27="$([ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n": ${l_result_27}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
