#!/bin/bash

# Configure ly (lightweight display manager)
# Replaces sddm for a lighter alternative

# Install ly if not already installed
if ! command -v ly &> /dev/null; then
  echo "Installing ly..."
  sudo pacman -S --noconfirm ly || {
    echo "Warning: Failed to install ly. It may need to be installed manually."
    exit 1
  }
fi

# Enable ly service
sudo systemctl enable ly.service

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

