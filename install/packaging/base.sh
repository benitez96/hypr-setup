# Function to install yay from AUR if not available
install_yay() {
  if command -v yay &>/dev/null; then
    return 0
  fi

  echo "Installing yay from AUR..."
  # Ensure base-devel is installed
  sudo pacman -S --needed --noconfirm base-devel git || return 1
  
  cd /tmp
  rm -rf yay-bin
  if ! git clone https://aur.archlinux.org/yay-bin.git; then
    echo "Error: Failed to clone yay-bin repository"
    return 1
  fi
  
  cd yay-bin
  # makepkg must run as regular user, not sudo
  if ! makepkg -si --noconfirm; then
    cd -
    rm -rf /tmp/yay-bin
    echo "Error: Failed to build/install yay"
    return 1
  fi
  
  cd -
  rm -rf /tmp/yay-bin
  return 0
}

# Function to check if a package exists in official repositories
package_in_repos() {
  local pkg="$1"
  # Check if package exists in any official repository
  pacman -Ss --quiet "^${pkg}$" 2>/dev/null | grep -q "^\[.*\] ${pkg} " && return 0
  return 1
}

# Read all packages from the list
mapfile -t packages < <(grep -v '^#' "$HYPR_SETUP_INSTALL/base.packages" | grep -v '^$')

# Separate packages into official repos and AUR
official_packages=()
aur_packages=()

for pkg in "${packages[@]}"; do
  # Skip if already installed
  if pacman -Q "$pkg" &>/dev/null; then
    continue
  fi
  
  if package_in_repos "$pkg"; then
    official_packages+=("$pkg")
  else
    aur_packages+=("$pkg")
  fi
done

# Install official packages first (batch install for efficiency)
if [[ ${#official_packages[@]} -gt 0 ]]; then
  echo "Installing packages from official repositories..."
  sudo pacman -S --noconfirm --needed "${official_packages[@]}" || true
fi

# Install AUR packages if any
if [[ ${#aur_packages[@]} -gt 0 ]]; then
  echo "Installing packages from AUR..."
  
  # Ensure yay is available
  if ! install_yay; then
    echo "Error: Failed to install yay, cannot install AUR packages"
    echo "The following packages require AUR and could not be installed:"
    printf '  - %s\n' "${aur_packages[@]}"
    exit 1
  fi
  
  # Install AUR packages one by one
  failed_aur=()
  for pkg in "${aur_packages[@]}"; do
    # Double-check it's still not installed (might have been a dependency)
    if pacman -Q "$pkg" &>/dev/null; then
      continue
    fi
    
    echo "Installing '$pkg' from AUR..."
    if yay -S --noconfirm "$pkg" 2>/dev/null; then
      echo "Successfully installed '$pkg'"
    else
      echo "Warning: Failed to install '$pkg' from AUR"
      failed_aur+=("$pkg")
    fi
  done
  
  # Report AUR failures
  if [[ ${#failed_aur[@]} -gt 0 ]]; then
    echo "Warning: The following AUR packages could not be installed:"
    printf '  - %s\n' "${failed_aur[@]}"
  fi
fi
