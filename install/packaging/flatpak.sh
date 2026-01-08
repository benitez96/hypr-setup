#!/bin/bash

# Install and configure Flatpak with Flathub
# Then install: brave, libreoffice, evince, and flatseal

echo "Configuring Flatpak..."

# Ensure flatpak is installed (should be installed via base.packages)
if ! command -v flatpak &>/dev/null; then
  echo "Warning: flatpak not found. Installing..."
  sudo pacman -S --noconfirm --needed flatpak || {
    echo "Error: Failed to install flatpak"
    return 1
  }
fi

# Add Flathub remote if not already added
if ! flatpak remote-list | grep -q "flathub"; then
  echo "Adding Flathub remote..."
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || {
    echo "Error: Failed to add Flathub remote"
    return 1
  }
else
  echo "Flathub remote already configured"
fi

# Update flatpak remotes
echo "Updating Flatpak remotes..."
flatpak update --noninteractive || true

# List of flatpak applications to install
flatpak_apps=(
  "com.brave.Browser"           # Brave Browser
  "org.libreoffice.LibreOffice" # LibreOffice
  "org.gnome.Evince"            # Evince (Document Viewer)
  "com.github.tchx84.Flatseal"  # Flatseal
)

# Install each flatpak application
for app in "${flatpak_apps[@]}"; do
  # Check if already installed
  if flatpak list | grep -q "$app"; then
    echo "Skipping '$app' (already installed)"
    continue
  fi
  
  echo "Installing '$app' from Flathub..."
  if flatpak install --noninteractive --assumeyes flathub "$app" 2>/dev/null; then
    echo "Successfully installed '$app'"
  else
    echo "Warning: Failed to install '$app' from Flathub"
  fi
done

echo "Flatpak configuration completed"

