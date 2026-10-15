#!/bin/bash
# RHL9-52 | Ensure GDM screen locks cannot be overridden

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

   l_result_17="$(Look for idle-delay to determine profile in use, needed for remaining tests 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - Look for idle-delay to determine profile in use, needed for remaining tests: no output (PASS)"
   else
      l_output2="$l_output2\n - Look for idle-delay to determine profile in use, needed for remaining tests: ${l_result_17}"
   fi

   l_result_18="$(l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked: no output (PASS)"
   else
      l_output2="$l_output2\n - l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked: ${l_result_18}"
   fi

   l_result_19="$(l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked: no output (PASS)"
   else
      l_output2="$l_output2\n - l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked: ${l_result_19}"
   fi

   l_result_20="$(if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked: ${l_result_20}"
   fi

   l_result_21="$(if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then: ${l_result_21}"
   fi

   l_result_22="$(l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\"" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\"": ${l_result_22}"
   fi

   l_result_23="$(else 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_23}"
   fi

   l_result_24="$(l_output2="$l_output2\n - \"idle-delay\" is not locked" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"idle-delay\" is not locked": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"idle-delay\" is not locked": ${l_result_24}"
   fi

   l_result_25="$(else 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_25}"
   fi

   l_result_26="$(l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked": ${l_result_26}"
   fi

   l_result_27="$(if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked: ${l_result_27}"
   fi

   l_result_28="$(if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then: ${l_result_28}"
   fi

   l_result_29="$(l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\"" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\"": ${l_result_29}"
   fi

   l_result_30="$(else 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_30}"
   fi

   l_result_31="$(l_output2="$l_output2\n - \"lock-delay\" is not locked" 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"lock-delay\" is not locked": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"lock-delay\" is not locked": ${l_result_31}"
   fi

   l_result_32="$(else 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_32}"
   fi

   l_result_33="$(l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked" 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked": ${l_result_33}"
   fi

   l_result_34="$(else 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_34}"
   fi

   l_result_35="$(l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable" 2>/dev/null)"
   if [ -z "${l_result_35}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": ${l_result_35}"
   fi

   l_result_36="$(Report results. If no failures output in l_output2, we pass 2>/dev/null)"
   if [ -z "${l_result_36}" ]; then
      l_output="$l_output\n - Report results. If no failures output in l_output2, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - Report results. If no failures output in l_output2, we pass: ${l_result_36}"
   fi

   l_result_37="$([ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput" 2>/dev/null)"
   if [ -z "${l_result_37}" ]; then
      l_output="$l_output\n - [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput": ${l_result_37}"
   fi

   l_result_38="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_38}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_38}"
   fi

   l_result_39="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_39}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_39}"
   fi

   l_result_40="$(else 2>/dev/null)"
   if [ -z "${l_result_40}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_40}"
   fi

   l_result_41="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_41}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_41}"
   fi

   l_result_42="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_42}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_42}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
