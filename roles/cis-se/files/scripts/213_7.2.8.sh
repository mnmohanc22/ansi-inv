#!/bin/bash

{
   l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2=""
   l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$"
   unset a_uarr && a_uarr=() # Clear and initialize array
   while read -r l_epu l_eph; do # Populate array with users and user home location
      a_uarr+=("$l_epu $l_eph")
   done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)"
   l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding
   [ "$l_asize " -gt "10000" ] && echo -e "
  ** INFO **
  - \"$l_asize\" Local interactive users found on the system
  - This may be a long running check
"
   while read -r l_user l_home; do
      if [ -d "$l_home" ]; then
         l_mask='0027'
         l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )"
         while read -r l_own l_mode; do
            [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2
  - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\""
            if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
               l_haout2="$l_haout2
  - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive"
            fi
         done <<< "$(stat -Lc '%U %#a' "$l_home")"
      else
         l_heout2="$l_heout2
  - User: \"$l_user\" Home \"$l_home\" Doesn't exist"
      fi
   done <<< "$(printf '%s
' "${a_uarr[@]}")"
   [ -z "$l_heout2" ] && l_output="$l_output
   - home directories exist" || l_output2="$l_output2$l_heout2"
   [ -z "$l_hoout2" ] && l_output="$l_output
   - own their home directory" || l_output2="$l_output2$l_hoout2"
   [ -z "$l_haout2" ] && l_output="$l_output
   - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2"
   [ -n "$l_output" ] && l_output="  - All local interactive users:$l_output"
   if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
      echo -e "
- Audit Result:
  ** PASS **
 - * Correctly configured * :
$l_output"
   else
      echo -e "
- Audit Result:
  ** FAIL **
 - * Reasons for audit failure * :
$l_output2"
      [ -n "$l_output" ] && echo -e "
- * Correctly configured * :
$l_output"
   fi
}