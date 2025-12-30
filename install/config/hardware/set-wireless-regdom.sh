# First check that wireless-regdb is there
if [ -f "/etc/conf.d/wireless-regdom" ]; then
  unset WIRELESS_REGDOM
  . /etc/conf.d/wireless-regdom
fi

# If the region is already set, we're done
if [ ! -n "${WIRELESS_REGDOM}" ]; then
  # Get the current timezone
  if [ -e "/etc/localtime" ]; then
    TIMEZONE=$(readlink -f /etc/localtime 2>/dev/null)
    if [ -z "$TIMEZONE" ]; then
      echo "Warning: Could not determine timezone from /etc/localtime"
      exit 0
    fi
    
    TIMEZONE=${TIMEZONE#/usr/share/zoneinfo/}
    if [ -z "$TIMEZONE" ]; then
      echo "Warning: Could not parse timezone"
      exit 0
    fi

    # Some timezones are formatted with the two letter country code at the start
    COUNTRY="${TIMEZONE%%/*}"

    # If we don't have a two letter country, get it from the timezone table
    if [[ ! "$COUNTRY" =~ ^[A-Z]{2}$ ]] && [ -f "/usr/share/zoneinfo/zone.tab" ]; then
      COUNTRY=$(awk -v tz="$TIMEZONE" '$3 == tz {print $1; exit}' /usr/share/zoneinfo/zone.tab 2>/dev/null)
    fi

    # Check if we have a valid two letter country code
    if [[ "$COUNTRY" =~ ^[A-Z]{2}$ ]]; then
      # Ensure the conf.d directory exists
      sudo mkdir -p /etc/conf.d
      
      # Append it to the wireless-regdom conf file that is used at boot
      # Only append if not already present
      if ! grep -q "WIRELESS_REGDOM" /etc/conf.d/wireless-regdom 2>/dev/null; then
        echo "WIRELESS_REGDOM=\"$COUNTRY\"" | sudo tee -a /etc/conf.d/wireless-regdom >/dev/null
      fi

      # Also set it one off now (if iw is available and we have wireless hardware)
      if command -v iw &>/dev/null; then
        # Check if there are any wireless interfaces before trying to set region
        if ip link show | grep -q "wlan\|wifi" 2>/dev/null || ls /sys/class/net/ | grep -q "wlan\|wifi" 2>/dev/null; then
          if sudo iw reg set "$COUNTRY" 2>/dev/null; then
            echo "Wireless regulatory domain set to $COUNTRY"
          else
            echo "Warning: Failed to set wireless regulatory domain to $COUNTRY (this is non-fatal)"
          fi
        else
          echo "No wireless interfaces found, skipping iw reg set"
        fi
      fi
    else
      echo "Warning: Could not determine valid country code from timezone '$TIMEZONE' (got: '$COUNTRY')"
    fi
  fi
fi
