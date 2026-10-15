#!/bin/bash
# RHL9-51 | Ensure GDM screen locks when the user is idle

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(Check if GNMOE Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - Check if GNMOE Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if GNMOE Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n: ${l_result_2}"
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

   l_result_17="$(l_idmv="900" # Set for max value for idle-delay in seconds 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - l_idmv="900" # Set for max value for idle-delay in seconds: no output (PASS)"
   else
      l_output2="$l_output2\n - l_idmv="900" # Set for max value for idle-delay in seconds: ${l_result_17}"
   fi

   l_result_18="$(l_ldmv="5" # Set for max value for lock-delay in seconds 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - l_ldmv="5" # Set for max value for lock-delay in seconds: no output (PASS)"
   else
      l_output2="$l_output2\n - l_ldmv="5" # Set for max value for lock-delay in seconds: ${l_result_18}"
   fi

   l_result_19="$(Look for idle-delay to determine profile in use, needed for remaining tests 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - Look for idle-delay to determine profile in use, needed for remaining tests: no output (PASS)"
   else
      l_output2="$l_output2\n - Look for idle-delay to determine profile in use, needed for remaining tests: ${l_result_19}"
   fi

   l_result_20="$(l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/)" # Determine file containing idle-delay key 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/)" # Determine file containing idle-delay key: no output (PASS)"
   else
      l_output2="$l_output2\n - l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/)" # Determine file containing idle-delay key: ${l_result_20}"
   fi

   l_result_21="$(if [ -n "$l_kfile" ]; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if [ -n "$l_kfile" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_kfile" ]; then: ${l_result_21}"
   fi

   l_result_22="$(set profile name (This is the name of a dconf database) 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - set profile name (This is the name of a dconf database): no output (PASS)"
   else
      l_output2="$l_output2\n - set profile name (This is the name of a dconf database): ${l_result_22}"
   fi

   l_result_23="$(l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")" #Set the key profile name 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")" #Set the key profile name: no output (PASS)"
   else
      l_output2="$l_output2\n - l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")" #Set the key profile name: ${l_result_23}"
   fi

   l_result_24="$(l_pdbdir="/etc/dconf/db/$l_profile.d" # Set the key file dconf db directory 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - l_pdbdir="/etc/dconf/db/$l_profile.d" # Set the key file dconf db directory: no output (PASS)"
   else
      l_output2="$l_output2\n - l_pdbdir="/etc/dconf/db/$l_profile.d" # Set the key file dconf db directory: ${l_result_24}"
   fi

   l_result_25="$(Confirm that idle-delay exists, includes unit32, and value is between 1 and max value for idle-delay 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - Confirm that idle-delay exists, includes unit32, and value is between 1 and max value for idle-delay: no output (PASS)"
   else
      l_output2="$l_output2\n - Confirm that idle-delay exists, includes unit32, and value is between 1 and max value for idle-delay: ${l_result_25}"
   fi

   l_result_26="$(l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | xargs)" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | xargs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | xargs)": ${l_result_26}"
   fi

   l_result_27="$(if [ -n "$l_idv" ]; then 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - if [ -n "$l_idv" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_idv" ]; then: ${l_result_27}"
   fi

   l_result_28="$([ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" seconds in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - [ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" seconds in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" seconds in \"$l_kfile\"": ${l_result_28}"
   fi

   l_result_29="$([ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - [ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\"": ${l_result_29}"
   fi

   l_result_30="$([ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - [ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in \"$l_kfile\"": ${l_result_30}"
   fi

   l_result_31="$(else 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_31}"
   fi

   l_result_32="$(l_output2="$l_output2\n - The \"idle-delay\" option is not set in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The \"idle-delay\" option is not set in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The \"idle-delay\" option is not set in \"$l_kfile\"": ${l_result_32}"
   fi

   l_result_33="$(Confirm that lock-delay exists, includes unit32, and value is between 0 and max value for lock-delay 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - Confirm that lock-delay exists, includes unit32, and value is between 0 and max value for lock-delay: no output (PASS)"
   else
      l_output2="$l_output2\n - Confirm that lock-delay exists, includes unit32, and value is between 0 and max value for lock-delay: ${l_result_33}"
   fi

   l_result_34="$(l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | xargs)" 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | xargs)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | xargs)": ${l_result_34}"
   fi

   l_result_35="$(if [ -n "$l_ldv" ]; then 2>/dev/null)"
   if [ -z "${l_result_35}" ]; then
      l_output="$l_output\n - if [ -n "$l_ldv" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_ldv" ]; then: ${l_result_35}"
   fi

   l_result_36="$([ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_36}" ]; then
      l_output="$l_output\n - [ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds in \"$l_kfile\"": ${l_result_36}"
   fi

   l_result_37="$([ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_37}" ]; then
      l_output="$l_output\n - [ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - [ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in \"$l_kfile\"": ${l_result_37}"
   fi

   l_result_38="$(else 2>/dev/null)"
   if [ -z "${l_result_38}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_38}"
   fi

   l_result_39="$(l_output2="$l_output2\n - The \"lock-delay\" option is not set in \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_39}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The \"lock-delay\" option is not set in \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The \"lock-delay\" option is not set in \"$l_kfile\"": ${l_result_39}"
   fi

   l_result_40="$(Confirm that dconf profile exists 2>/dev/null)"
   if [ -z "${l_result_40}" ]; then
      l_output="$l_output\n - Confirm that dconf profile exists: no output (PASS)"
   else
      l_output2="$l_output2\n - Confirm that dconf profile exists: ${l_result_40}"
   fi

   l_result_41="$(if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then 2>/dev/null)"
   if [ -z "${l_result_41}" ]; then
      l_output="$l_output\n - if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then: ${l_result_41}"
   fi

   l_result_42="$(l_output="$l_output\n - The \"$l_profile\" profile exists" 2>/dev/null)"
   if [ -z "${l_result_42}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - The \"$l_profile\" profile exists": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - The \"$l_profile\" profile exists": ${l_result_42}"
   fi

   l_result_43="$(else 2>/dev/null)"
   if [ -z "${l_result_43}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_43}"
   fi

   l_result_44="$(l_output2="$l_output2\n - The \"$l_profile\" doesn't exist" 2>/dev/null)"
   if [ -z "${l_result_44}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The \"$l_profile\" doesn't exist": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The \"$l_profile\" doesn't exist": ${l_result_44}"
   fi

   l_result_45="$(Confirm that dconf profile database file exists 2>/dev/null)"
   if [ -z "${l_result_45}" ]; then
      l_output="$l_output\n - Confirm that dconf profile database file exists: no output (PASS)"
   else
      l_output2="$l_output2\n - Confirm that dconf profile database file exists: ${l_result_45}"
   fi

   l_result_46="$(if [ -f "/etc/dconf/db/$l_profile" ]; then 2>/dev/null)"
   if [ -z "${l_result_46}" ]; then
      l_output="$l_output\n - if [ -f "/etc/dconf/db/$l_profile" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -f "/etc/dconf/db/$l_profile" ]; then: ${l_result_46}"
   fi

   l_result_47="$(l_output="$l_output\n - The \"$l_profile\" profile exists in the dconf database" 2>/dev/null)"
   if [ -z "${l_result_47}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - The \"$l_profile\" profile exists in the dconf database": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - The \"$l_profile\" profile exists in the dconf database": ${l_result_47}"
   fi

   l_result_48="$(else 2>/dev/null)"
   if [ -z "${l_result_48}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_48}"
   fi

   l_result_49="$(l_output2="$l_output2\n - The \"$l_profile\" profile doesn't exist in the dconf database" 2>/dev/null)"
   if [ -z "${l_result_49}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The \"$l_profile\" profile doesn't exist in the dconf database": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The \"$l_profile\" profile doesn't exist in the dconf database": ${l_result_49}"
   fi

   l_result_50="$(else 2>/dev/null)"
   if [ -z "${l_result_50}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_50}"
   fi

   l_result_51="$(l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, remaining tests skipped" 2>/dev/null)"
   if [ -z "${l_result_51}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, remaining tests skipped": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, remaining tests skipped": ${l_result_51}"
   fi

   l_result_52="$(else 2>/dev/null)"
   if [ -z "${l_result_52}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_52}"
   fi

   l_result_53="$(l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable" 2>/dev/null)"
   if [ -z "${l_result_53}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": ${l_result_53}"
   fi

   l_result_54="$(Report results. If no failures output in l_output2, we pass 2>/dev/null)"
   if [ -z "${l_result_54}" ]; then
      l_output="$l_output\n - Report results. If no failures output in l_output2, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - Report results. If no failures output in l_output2, we pass: ${l_result_54}"
   fi

   l_result_55="$([ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput" 2>/dev/null)"
   if [ -z "${l_result_55}" ]; then
      l_output="$l_output\n - [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput": ${l_result_55}"
   fi

   l_result_56="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_56}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_56}"
   fi

   l_result_57="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_57}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_57}"
   fi

   l_result_58="$(else 2>/dev/null)"
   if [ -z "${l_result_58}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_58}"
   fi

   l_result_59="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_59}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_59}"
   fi

   l_result_60="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_60}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_60}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
