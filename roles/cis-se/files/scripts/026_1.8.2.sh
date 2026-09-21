l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput
 - Package: \"$l_pn\" exists on the system
 - checking configuration"
   done
   if [ -n "$l_pkgoutput" ]; then
      l_output="" l_output2=""
      echo -e "$l_pkgoutput"
      # Look for existing settings and set variables if they exist
      l_gdmfile="$(grep -Prils '^\h*banner-message-enable\b' /etc/dconf/db/*.d)"
      if [ -n "$l_gdmfile" ]; then
         # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
         l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
         # Check if banner message is enabled
         if grep -Pisq '^\h*banner-message-enable=true\b' "$l_gdmfile"; then
            l_output="$l_output
 - The \"banner-message-enable\" option is enabled in \"$l_gdmfile\""
         else
            l_output2="$l_output2
 - The \"banner-message-enable\" option is not enabled"
         fi
         l_lsbt="$(grep -Pios '^\h*banner-message-text=.*$' "$l_gdmfile")"
         if [ -n "$l_lsbt" ]; then
            l_output="$l_output
 - The \"banner-message-text\" option is set in \"$l_gdmfile\"
  - banner-message-text is set to:
  - \"$l_lsbt\""
         else
            l_output2="$l_output2
 - The \"banner-message-text\" option is not set"
         fi
         if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
            l_output="$l_output
 - The \"$l_gdmprofile\" profile exists"
         else
            l_output2="$l_output2
 - The \"$l_gdmprofile\" profile doesn't exist"
         fi
         if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
            l_output="$l_output
 - The \"$l_gdmprofile\" profile exists in the dconf database"
         else
            l_output2="$l_output2
 - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
         fi
      else
         l_output2="$l_output2
 - The \"banner-message-enable\" option isn't configured"
      fi
   else
      echo -e "
 - GNOME Desktop Manager isn't installed
 - Recommendation is Not Applicable
- Audit result:
  *** PASS ***
"
   fi
   # Report results. If no failures output in l_output2, we pass
   if [ -z "$l_output2" ]; then
      echo -e "
- Audit Result:
  ** PASS **
$l_output
"
   else
      echo -e "
- Audit Result:
  ** FAIL **
 - Reason(s) for audit failure:
$l_output2
"
      [ -n "$l_output" ] && echo -e "
- Correctly set:
$l_output
"
   fi