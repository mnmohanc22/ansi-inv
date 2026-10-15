#!/bin/bash
# RHL9-55 | Ensure GDM autorun-never is enabled

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_pkgoutput="" l_output="" l_output2="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_pkgoutput="" l_output="" l_output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pkgoutput="" l_output="" l_output2="": ${l_result_2}"
   fi

   l_result_3="$(Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n: ${l_result_3}"
   fi

   l_result_4="$(determine system's package manager 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - determine system's package manager: no output (PASS)"
   else
      l_output2="$l_output2\n - determine system's package manager: ${l_result_4}"
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

   l_result_13="$(echo -e "$l_pkgoutput" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - echo -e "$l_pkgoutput": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "$l_pkgoutput": ${l_result_13}"
   fi

   l_result_14="$(done 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - done: no output (PASS)"
   else
      l_output2="$l_output2\n - done: ${l_result_14}"
   fi

   l_result_15="$(Check configuration (If applicable) 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - Check configuration (If applicable): no output (PASS)"
   else
      l_output2="$l_output2\n - Check configuration (If applicable): ${l_result_15}"
   fi

   l_result_16="$(if [ -n "$l_pkgoutput" ]; then 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - if [ -n "$l_pkgoutput" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_pkgoutput" ]; then: ${l_result_16}"
   fi

   l_result_17="$(echo -e "$l_pkgoutput" 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - echo -e "$l_pkgoutput": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "$l_pkgoutput": ${l_result_17}"
   fi

   l_result_18="$(Look for existing settings and set variables if they exist 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - Look for existing settings and set variables if they exist: no output (PASS)"
   else
      l_output2="$l_output2\n - Look for existing settings and set variables if they exist: ${l_result_18}"
   fi

   l_result_19="$(l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)" 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)": ${l_result_19}"
   fi

   l_result_20="$(Set profile name based on dconf db directory ({PROFILE_NAME}.d) 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - Set profile name based on dconf db directory ({PROFILE_NAME}.d): no output (PASS)"
   else
      l_output2="$l_output2\n - Set profile name based on dconf db directory ({PROFILE_NAME}.d): ${l_result_20}"
   fi

   l_result_21="$(if [ -f "$l_kfile" ]; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if [ -f "$l_kfile" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -f "$l_kfile" ]; then: ${l_result_21}"
   fi

   l_result_22="$(l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")": no output (PASS)"
   else
      l_output2="$l_output2\n - l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")": ${l_result_22}"
   fi

   l_result_23="$(If the profile name exist, continue checks 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - If the profile name exist, continue checks: no output (PASS)"
   else
      l_output2="$l_output2\n - If the profile name exist, continue checks: ${l_result_23}"
   fi

   l_result_24="$(if [ -n "$l_gpname" ]; then 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - if [ -n "$l_gpname" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_gpname" ]; then: ${l_result_24}"
   fi

   l_result_25="$(l_gpdir="/etc/dconf/db/$l_gpname.d" 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - l_gpdir="/etc/dconf/db/$l_gpname.d": no output (PASS)"
   else
      l_output2="$l_output2\n - l_gpdir="/etc/dconf/db/$l_gpname.d": ${l_result_25}"
   fi

   l_result_26="$(Check if profile file exists 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - Check if profile file exists: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if profile file exists: ${l_result_26}"
   fi

   l_result_27="$(if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then: ${l_result_27}"
   fi

   l_result_28="$(l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists": ${l_result_28}"
   fi

   l_result_29="$(else 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_29}"
   fi

   l_result_30="$(l_output2="$l_output2\n - dconf database profile isn't set" 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - dconf database profile isn't set": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - dconf database profile isn't set": ${l_result_30}"
   fi

   l_result_31="$(Check if the dconf database file exists 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - Check if the dconf database file exists: no output (PASS)"
   else
      l_output2="$l_output2\n - Check if the dconf database file exists: ${l_result_31}"
   fi

   l_result_32="$(if [ -f "/etc/dconf/db/$l_gpname" ]; then 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - if [ -f "/etc/dconf/db/$l_gpname" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -f "/etc/dconf/db/$l_gpname" ]; then: ${l_result_32}"
   fi

   l_result_33="$(l_output="$l_output\n - The dconf database \"$l_gpname\" exists" 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - The dconf database \"$l_gpname\" exists": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - The dconf database \"$l_gpname\" exists": ${l_result_33}"
   fi

   l_result_34="$(else 2>/dev/null)"
   if [ -z "${l_result_34}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_34}"
   fi

   l_result_35="$(l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist" 2>/dev/null)"
   if [ -z "${l_result_35}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist": ${l_result_35}"
   fi

   l_result_36="$(check if the dconf database directory exists 2>/dev/null)"
   if [ -z "${l_result_36}" ]; then
      l_output="$l_output\n - check if the dconf database directory exists: no output (PASS)"
   else
      l_output2="$l_output2\n - check if the dconf database directory exists: ${l_result_36}"
   fi

   l_result_37="$(if [ -d "$l_gpdir" ]; then 2>/dev/null)"
   if [ -z "${l_result_37}" ]; then
      l_output="$l_output\n - if [ -d "$l_gpdir" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -d "$l_gpdir" ]; then: ${l_result_37}"
   fi

   l_result_38="$(l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst" 2>/dev/null)"
   if [ -z "${l_result_38}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst": ${l_result_38}"
   fi

   l_result_39="$(else 2>/dev/null)"
   if [ -z "${l_result_39}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_39}"
   fi

   l_result_40="$(l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist" 2>/dev/null)"
   if [ -z "${l_result_40}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist": ${l_result_40}"
   fi

   l_result_41="$(check autorun-never setting 2>/dev/null)"
   if [ -z "${l_result_41}" ]; then
      l_output="$l_output\n - check autorun-never setting: no output (PASS)"
   else
      l_output2="$l_output2\n - check autorun-never setting: ${l_result_41}"
   fi

   l_result_42="$(if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then 2>/dev/null)"
   if [ -z "${l_result_42}" ]; then
      l_output="$l_output\n - if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then: ${l_result_42}"
   fi

   l_result_43="$(l_output="$l_output\n - \"autorun-never\" is set to true in: \"$l_kfile\"" 2>/dev/null)"
   if [ -z "${l_result_43}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - \"autorun-never\" is set to true in: \"$l_kfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - \"autorun-never\" is set to true in: \"$l_kfile\"": ${l_result_43}"
   fi

   l_result_44="$(else 2>/dev/null)"
   if [ -z "${l_result_44}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_44}"
   fi

   l_result_45="$(l_output2="$l_output2\n - \"autorun-never\" is not set correctly" 2>/dev/null)"
   if [ -z "${l_result_45}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"autorun-never\" is not set correctly": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"autorun-never\" is not set correctly": ${l_result_45}"
   fi

   l_result_46="$(else 2>/dev/null)"
   if [ -z "${l_result_46}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_46}"
   fi

   l_result_47="$(Settings don't exist. Nothing further to check 2>/dev/null)"
   if [ -z "${l_result_47}" ]; then
      l_output="$l_output\n - Settings don't exist. Nothing further to check: no output (PASS)"
   else
      l_output2="$l_output2\n - Settings don't exist. Nothing further to check: ${l_result_47}"
   fi

   l_result_48="$(l_output2="$l_output2\n - \"autorun-never\" is not set" 2>/dev/null)"
   if [ -z "${l_result_48}" ]; then
      l_output="$l_output\n - l_output2="$l_output2\n - \"autorun-never\" is not set": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output2="$l_output2\n - \"autorun-never\" is not set": ${l_result_48}"
   fi

   l_result_49="$(else 2>/dev/null)"
   if [ -z "${l_result_49}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_49}"
   fi

   l_result_50="$(l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable" 2>/dev/null)"
   if [ -z "${l_result_50}" ]; then
      l_output="$l_output\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": no output (PASS)"
   else
      l_output2="$l_output2\n - l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable": ${l_result_50}"
   fi

   l_result_51="$(Report results. If no failures output in l_output2, we pass 2>/dev/null)"
   if [ -z "${l_result_51}" ]; then
      l_output="$l_output\n - Report results. If no failures output in l_output2, we pass: no output (PASS)"
   else
      l_output2="$l_output2\n - Report results. If no failures output in l_output2, we pass: ${l_result_51}"
   fi

   l_result_52="$(if [ -z "$l_output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_52}" ]; then
      l_output="$l_output\n - if [ -z "$l_output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$l_output2" ]; then: ${l_result_52}"
   fi

   l_result_53="$(echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_53}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n": ${l_result_53}"
   fi

   l_result_54="$(else 2>/dev/null)"
   if [ -z "${l_result_54}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_54}"
   fi

   l_result_55="$(echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n" 2>/dev/null)"
   if [ -z "${l_result_55}" ]; then
      l_output="$l_output\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n": ${l_result_55}"
   fi

   l_result_56="$([ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n" 2>/dev/null)"
   if [ -z "${l_result_56}" ]; then
      l_output="$l_output\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n": ${l_result_56}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
