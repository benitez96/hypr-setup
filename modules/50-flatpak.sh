#!/usr/bin/env bash
set -euo pipefail

echo "[50] Configuring Flatpak (Flathub + basic apps)..."

# Add Flathub
# if ! flatpak remote-list | grep -q flathub; then
#   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# fi

# GTK theme for Flatpak apps
# flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3

# Browser + Office + Flatseal
# flatpak install -y flathub \
#   com.brave.Browser \
#   org.libreoffice.LibreOffice \
#   com.github.tchx84.Flatseal \
#   org.gnome.Evince

echo "[50] Flatpak configuration skipped (commented for testing)."
