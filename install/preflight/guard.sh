abort() {
  echo -e "\e[31mHypr Setup install requires: $1\e[0m"
  echo
  gum confirm "Proceed anyway on your own accord and without assistance?" || exit 1
}

# Must be an Arch distro
if [[ ! -f /etc/arch-release ]]; then
  abort "Vanilla Arch"
fi

# Must not be an Arch derivative distro
for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  if [[ -f "$marker" ]]; then
    abort "Vanilla Arch"
  fi
done

# Must not be running as root
if [ "$EUID" -eq 0 ]; then
  abort "Running as root (not user)"
fi

# Must be x86 only to fully work
if [ "$(uname -m)" != "x86_64" ]; then
  abort "x86_64 CPU"
fi

# Must not have Gnome or KDE already install
if pacman -Qe gnome-shell &>/dev/null || pacman -Qe plasma-desktop &>/dev/null; then
  abort "Fresh + Vanilla Arch"
fi

# Optional: Check if Btrfs is being used (for future Snapper configuration)
# If HYPR_SETUP_ENABLE_SNAPPER is set and filesystem is Btrfs, Snapper will be configured
export HYPR_SETUP_HAS_BTRFS=false
if [ "$(findmnt -n -o FSTYPE /)" = "btrfs" ]; then
  export HYPR_SETUP_HAS_BTRFS=true
fi 

# Cleared all guards
echo "Guards: OK"
