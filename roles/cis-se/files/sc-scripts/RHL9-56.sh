#!/bin/bash
# RHL9-56 | Ensure GDM autorun-never is not overridden

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n: ${l_result_2}"
   fi

   l_result_3="$(determine system's package manager 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - determine system's package manager: no output (PASS)"
   else
      l_output2="$l_output2\n - determine system's package manager: ${l_result_3}"
   fi

   l_result_4="$(l_pkgoutput="" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_pkgoutput="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pkgoutput="": ${l_result_4}"
   fi

   l_result_5="$(if command -v dpkg-query > /dev/null 2> then 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - if command -v dpkg-query > /dev/null 2> then: no output (PASS)"
   else
      l_output2="$l_output2\n - if command -v dpkg-query > /dev/null 2> then: ${l_result_5}"
   fi

   l_result_6="$(l_pq="dpkg-query -W" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_pq="dpkg-query -W": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pq="dpkg-query -W": ${l_result_6}"
   fi

   l_result_7="$(elif command -v rpm > /dev/null 2> then 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - elif command -v rpm > /dev/null 2> then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif command -v rpm > /dev/null 2> then: ${l_result_7}"
   fi

   l_result_8="$(l_pq="rpm -q" 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - l_pq="rpm -q": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pq="rpm -q": ${l_result_8}"
   fi

   l_result_9="$(Check if GDM is installed 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - Check if GDM is installed: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if GDM is installed: ${l_result_9}"
   fi

   l_result_10="$(l_pcl="gdm gdm3" # Space separated list of packages to check 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - l_pcl="gdm gdm3" # Space separated list of packages to check: no output (PASS)"
   else
      l_output2="$l_output2\n - l_pcl="gdm gdm3" # Space separated list of packages to check: ${l_result_10}"
   fi

   l_result_11="$(for l_pn in $l_pcl; do 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - for l_pn in $l_pcl; do: no output (PASS)"
   else
      l_output2="$l_output2\n - for l_pn in $l_pcl; do: ${l_result_11}"
   fi

   l_result_12="$($l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration": no output (PASS)"
   else
      l_output2="$l_output2\n - $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration": ${l_result_12}"
   fi

   l_result_13="$(done 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - done: no output (PASS)"
   else
      l_output2="$l_output2\n - done: ${l_result_13}"
   fi

   l_result_14="$(Check configuration (If applicable) 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - Check configuration (If applicable): no output (PASS)"
   else
      l_output2="$l_output2\n - Check configuration (If applicable): ${l_result_14}"
   fi

   l_result_15="$(if [ -n "$l_pkgoutput" ]; then 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - if [ -n "$l_pkgoutput" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_pkgoutput" ]; then: ${l_result_15}"
   fi

   l_result_16="$(l_output="" l_output2="" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_output="" l_output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="" l_output2="": ${l_result_16}"
   fi

   l_result_17="$(echo -e "$l_pkgoutput\n" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - echo -e "$l_pkgoutput\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "$l_pkgoutput\n": ${l_result_17}"
   fi

   l_result_18="$(Look for idle-delay to determine profile in use, needed for remaining tests 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - Look for idle-delay to determine profile in use, needed for remaining tests: no output (PASS)"
   else
      l_output2="$l_output2\n - Look for idle-delay to determine profile in use, needed for remaining tests: ${l_result_18}"
   fi

   l_result_19="$(l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked: no output (PASS)"
   else
      l_output2="$l_output2\n - l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked: ${l_result_19}"
   fi

   l_result_20="$(if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked: ${l_result_20}"
   fi

   l_result_21="$(if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then: ${l_result_21}"
   fi

   l_result_22="$(l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\"" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\"": ${l_result_22}"
   fi

   l_result_23="$(else 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_23}"
   fi

   l_result_24="$(l_output2="$l_output2\n - \"autorun-never\" is not locked" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"autorun-never\" is not locked": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"autorun-never\" is not locked": ${l_result_24}"
   fi

   l_result_25="$(else 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_25}"
   fi

   l_result_26="$(l_output2="$l_output2\n - \"autorun-never\" is not set so it can not be locked" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"autorun-never\" is not set so it can not be locked": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"autorun-never\" is not set so it can not be locked": ${l_result_26}"
   fi

   l_result_27="$(else 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_27}"
   fi

   l_result_28="$(l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": ${l_result_28}"
   fi

   l_result_29="$(Report results. If no failures output in l_output2, we pass 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - Report results. If no failures output in l_output2, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - Report results. If no failures output in l_output2, we pass: ${l_result_29}"
   fi

   l_result_30="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_30}"
   fi

   l_result_31="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_31}"
   fi

   l_result_32="$(else 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_32}"
   fi

   l_result_33="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_33}"
   fi

   l_result_34="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_34}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
