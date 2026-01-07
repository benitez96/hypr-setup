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

# Disable other display managers if they exist
if systemctl is-enabled sddm.service &>/dev/null; then
  echo "Disabling sddm service..."
  sudo systemctl disable sddm.service 2>/dev/null || true
fi

if systemctl is-enabled gdm.service &>/dev/null; then
  echo "Disabling gdm service..."
  sudo systemctl disable gdm.service 2>/dev/null || true
fi

if systemctl is-enabled lightdm.service &>/dev/null; then
  echo "Disabling lightdm service..."
  sudo systemctl disable lightdm.service 2>/dev/null || true
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

# Configure ly for Hyprland
sudo mkdir -p /etc/ly
if [[ ! -f /etc/ly/config.ini ]]; then
  cat <<EOF | sudo tee /etc/ly/config.ini
[main]
tty=2
x_cmd=start-hyprland

[display]
bg=clear
fg=clear
x=0
y=0
w=
h=

[input]
repeat_rate=25
repeat_delay=600

[command]
shutdown_cmd=systemctl poweroff
reboot_cmd=systemctl reboot
EOF
fi

echo "ly has been configured for Hyprland"

