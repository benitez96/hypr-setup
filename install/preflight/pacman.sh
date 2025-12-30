if [[ -n ${HYPR_SETUP_ONLINE_INSTALL:-} ]]; then
  # Install build tools
  sudo pacman -S --needed --noconfirm base-devel

  # Refresh all repos
  sudo pacman -Syu --noconfirm
fi
