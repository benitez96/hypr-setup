#!/usr/bin/env bash
set -euo pipefail

echo "[50] Configurando Flatpak (Flathub + apps básicas)..."

# Añadir Flathub
if ! flatpak remote-list | grep -q flathub; then
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Tema GTK para apps Flatpak
flatpak install -y flathub org.gtk.Gtk3theme.adw-gtk3

# Navegador + Ofimática + Flatseal
flatpak install -y flathub \
  com.brave.Browser \
  org.libreoffice.LibreOffice \
  com.github.tchx84.Flatseal \
  org.gnome.Evince

echo "[50] Flatpak configurado con Brave, LibreOffice y Flatseal."
