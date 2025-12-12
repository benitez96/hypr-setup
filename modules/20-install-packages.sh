#!/usr/bin/env bash
set -euo pipefail

echo "[20] Instalando paquetes oficiales con pacman..."

sudo pacman -Sy --needed --noconfirm \
  hyprland hyprpaper hypridle hyprlock \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  waybar mako fuzzel \
  networkmanager network-manager-applet networkmanager-dmenu \
  grim slurp swappy wl-clipboard \
  thunar thunar-volman tumbler \
  lf \
  zsh starship \
  papirus-icon-theme bibata-cursor-theme adw-gtk3 \
  cliphist playerctl jq \
  flatpak \
  greetd tuigreet

echo "[20] Instalando paquetes desde AUR con yay..."

yay -S --needed --noconfirm \
  ghostty \
  ttf-jetbrains-mono-nerd \
  lazygit \
  lazydocker
