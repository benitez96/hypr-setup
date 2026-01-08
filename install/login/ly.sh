#!/bin/bash

# Configure ly (lightweight display manager)
# Replaces sddm for a lighter alternative

# Source helper functions if available
if [[ -f "$HYPR_SETUP_INSTALL/helpers/chroot.sh" ]]; then
  source "$HYPR_SETUP_INSTALL/helpers/chroot.sh"
fi

# Install ly if not already installed
if ! command -v ly &> /dev/null; then
  echo "Installing ly..."
  sudo pacman -S --noconfirm ly || {
    echo "Warning: Failed to install ly. It may need to be installed manually."
    exit 1
  }
fi


# Disable getty on tty2 (ly runs on tty2 by default)
# This prevents getty from interfering with ly
sudo systemctl disable getty@tty2.service 2>/dev/null || true

# Enable ly service
# ly uses a template unit, so we need to enable the specific instance
# The default is tty2, so we enable ly@tty2.service
if command -v chrootable_systemctl_enable &> /dev/null; then
  chrootable_systemctl_enable ly@tty2.service
else
  # For manual installs, enable and start immediately
  sudo systemctl enable --now ly@tty2.service
fi


echo "ly has been configured for Hyprland"

