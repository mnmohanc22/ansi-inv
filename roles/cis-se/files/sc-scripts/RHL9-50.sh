#!/bin/bash
# RHL9-50 | Ensure GDM disable-user-list option is enabled

{
   l_output="" l_output2=""

   l_result_1="$(!/usr/bin/env bash 2>/dev/null)"
   if [ -z "${l_result_1}" ]; then
      l_output="$l_output\n - !/usr/bin/env bash: no output (PASS)"
   else
      l_output2="$l_output2\n - !/usr/bin/env bash: ${l_result_1}"
   fi

   l_result_2="$(l_pkgoutput="" 2>/dev/null)"
   if [ -z "${l_result_2}" ]; then
      l_output="$l_output\n - l_pkgoutput="": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pkgoutput="": ${l_result_2}"
   fi

   l_result_3="$(if command -v dpkg-query > /dev/null 2> then 2>/dev/null)"
   if [ -z "${l_result_3}" ]; then
      l_output="$l_output\n - if command -v dpkg-query > /dev/null 2> then: no output (PASS)"
   else
      l_output2="$l_output2\n - if command -v dpkg-query > /dev/null 2> then: ${l_result_3}"
   fi

   l_result_4="$(l_pq="dpkg-query -W" 2>/dev/null)"
   if [ -z "${l_result_4}" ]; then
      l_output="$l_output\n - l_pq="dpkg-query -W": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pq="dpkg-query -W": ${l_result_4}"
   fi

   l_result_5="$(elif command -v rpm > /dev/null 2> then 2>/dev/null)"
   if [ -z "${l_result_5}" ]; then
      l_output="$l_output\n - elif command -v rpm > /dev/null 2> then: no output (PASS)"
   else
      l_output2="$l_output2\n - elif command -v rpm > /dev/null 2> then: ${l_result_5}"
   fi

   l_result_6="$(l_pq="rpm -q" 2>/dev/null)"
   if [ -z "${l_result_6}" ]; then
      l_output="$l_output\n - l_pq="rpm -q": no output (PASS)"
   else
      l_output2="$l_output2\n - l_pq="rpm -q": ${l_result_6}"
   fi

   l_result_7="$(l_pcl="gdm gdm3" # Space separated list of packages to check 2>/dev/null)"
   if [ -z "${l_result_7}" ]; then
      l_output="$l_output\n - l_pcl="gdm gdm3" # Space separated list of packages to check: no output (PASS)"
   else
      l_output2="$l_output2\n - l_pcl="gdm gdm3" # Space separated list of packages to check: ${l_result_7}"
   fi

   l_result_8="$(for l_pn in $l_pcl; do 2>/dev/null)"
   if [ -z "${l_result_8}" ]; then
      l_output="$l_output\n - for l_pn in $l_pcl; do: no output (PASS)"
   else
      l_output2="$l_output2\n - for l_pn in $l_pcl; do: ${l_result_8}"
   fi

   l_result_9="$($l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration" 2>/dev/null)"
   if [ -z "${l_result_9}" ]; then
      l_output="$l_output\n - $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration": no output (PASS)"
   else
      l_output2="$l_output2\n - $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration": ${l_result_9}"
   fi

   l_result_10="$(done 2>/dev/null)"
   if [ -z "${l_result_10}" ]; then
      l_output="$l_output\n - done: no output (PASS)"
   else
      l_output2="$l_output2\n - done: ${l_result_10}"
   fi

   l_result_11="$(if [ -n "$l_pkgoutput" ]; then 2>/dev/null)"
   if [ -z "${l_result_11}" ]; then
      l_output="$l_output\n - if [ -n "$l_pkgoutput" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_pkgoutput" ]; then: ${l_result_11}"
   fi

   l_result_12="$(output="" output2="" 2>/dev/null)"
   if [ -z "${l_result_12}" ]; then
      l_output="$l_output\n - output="" output2="": no output (PASS)"
   else
      l_output2="$l_output2\n - output="" output2="": ${l_result_12}"
   fi

   l_result_13="$(l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)" 2>/dev/null)"
   if [ -z "${l_result_13}" ]; then
      l_output="$l_output\n - l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)": no output (PASS)"
   else
      l_output2="$l_output2\n - l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)": ${l_result_13}"
   fi

   l_result_14="$(if [ -n "$l_gdmfile" ]; then 2>/dev/null)"
   if [ -z "${l_result_14}" ]; then
      l_output="$l_output\n - if [ -n "$l_gdmfile" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -n "$l_gdmfile" ]; then: ${l_result_14}"
   fi

   l_result_15="$(output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\"" 2>/dev/null)"
   if [ -z "${l_result_15}" ]; then
      l_output="$l_output\n - output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\"": no output (PASS)"
   else
      l_output2="$l_output2\n - output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\"": ${l_result_15}"
   fi

   l_result_16="$(l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")" 2>/dev/null)"
   if [ -z "${l_result_16}" ]; then
      l_output="$l_output\n - l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")": no output (PASS)"
   else
      l_output2="$l_output2\n - l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")": ${l_result_16}"
   fi

   l_result_17="$(if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then 2>/dev/null)"
   if [ -z "${l_result_17}" ]; then
      l_output="$l_output\n - if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then: ${l_result_17}"
   fi

   l_result_18="$(output="$output\n - The \"$l_gdmprofile\" exists" 2>/dev/null)"
   if [ -z "${l_result_18}" ]; then
      l_output="$l_output\n - output="$output\n - The \"$l_gdmprofile\" exists": no output (PASS)"
   else
      l_output2="$l_output2\n - output="$output\n - The \"$l_gdmprofile\" exists": ${l_result_18}"
   fi

   l_result_19="$(else 2>/dev/null)"
   if [ -z "${l_result_19}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_19}"
   fi

   l_result_20="$(output2="$output2\n - The \"$l_gdmprofile\" doesn't exist" 2>/dev/null)"
   if [ -z "${l_result_20}" ]; then
      l_output="$l_output\n - output2="$output2\n - The \"$l_gdmprofile\" doesn't exist": no output (PASS)"
   else
      l_output2="$l_output2\n - output2="$output2\n - The \"$l_gdmprofile\" doesn't exist": ${l_result_20}"
   fi

   l_result_21="$(if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then 2>/dev/null)"
   if [ -z "${l_result_21}" ]; then
      l_output="$l_output\n - if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then: ${l_result_21}"
   fi

   l_result_22="$(output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database" 2>/dev/null)"
   if [ -z "${l_result_22}" ]; then
      l_output="$l_output\n - output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database": no output (PASS)"
   else
      l_output2="$l_output2\n - output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database": ${l_result_22}"
   fi

   l_result_23="$(else 2>/dev/null)"
   if [ -z "${l_result_23}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_23}"
   fi

   l_result_24="$(output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database" 2>/dev/null)"
   if [ -z "${l_result_24}" ]; then
      l_output="$l_output\n - output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database": no output (PASS)"
   else
      l_output2="$l_output2\n - output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database": ${l_result_24}"
   fi

   l_result_25="$(else 2>/dev/null)"
   if [ -z "${l_result_25}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_25}"
   fi

   l_result_26="$(output2="$output2\n - The \"disable-user-list\" option is not enabled" 2>/dev/null)"
   if [ -z "${l_result_26}" ]; then
      l_output="$l_output\n - output2="$output2\n - The \"disable-user-list\" option is not enabled": no output (PASS)"
   else
      l_output2="$l_output2\n - output2="$output2\n - The \"disable-user-list\" option is not enabled": ${l_result_26}"
   fi

   l_result_27="$(if [ -z "$output2" ]; then 2>/dev/null)"
   if [ -z "${l_result_27}" ]; then
      l_output="$l_output\n - if [ -z "$output2" ]; then: no output (PASS)"
   else
      l_output2="$l_output2\n - if [ -z "$output2" ]; then: ${l_result_27}"
   fi

   l_result_28="$(echo -e "$l_pkgoutput\n- Audit result:\n *** PASS: ***\n$output\n" 2>/dev/null)"
   if [ -z "${l_result_28}" ]; then
      l_output="$l_output\n - echo -e "$l_pkgoutput\n- Audit result:\n *** PASS: ***\n$output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "$l_pkgoutput\n- Audit result:\n *** PASS: ***\n$output\n": ${l_result_28}"
   fi

   l_result_29="$(else 2>/dev/null)"
   if [ -z "${l_result_29}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_29}"
   fi

   l_result_30="$(echo -e "$l_pkgoutput\n- Audit Result:\n *** FAIL: ***\n$output2\n" 2>/dev/null)"
   if [ -z "${l_result_30}" ]; then
      l_output="$l_output\n - echo -e "$l_pkgoutput\n- Audit Result:\n *** FAIL: ***\n$output2\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "$l_pkgoutput\n- Audit Result:\n *** FAIL: ***\n$output2\n": ${l_result_30}"
   fi

   l_result_31="$([ -n "$output" ] && echo -e "$output\n" 2>/dev/null)"
   if [ -z "${l_result_31}" ]; then
      l_output="$l_output\n - [ -n "$output" ] && echo -e "$output\n": no output (PASS)"
   else
      l_output2="$l_output2\n - [ -n "$output" ] && echo -e "$output\n": ${l_result_31}"
   fi

   l_result_32="$(else 2>/dev/null)"
   if [ -z "${l_result_32}" ]; then
      l_output="$l_output\n - else: no output (PASS)"
   else
      l_output2="$l_output2\n - else: ${l_result_32}"
   fi

   l_result_33="$(echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n *** PASS ***\n" 2>/dev/null)"
   if [ -z "${l_result_33}" ]; then
      l_output="$l_output\n - echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n *** PASS ***\n": no output (PASS)"
   else
      l_output2="$l_output2\n - echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n *** PASS ***\n": ${l_result_33}"
   fi


   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
