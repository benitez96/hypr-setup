#!/usr/bin/env bash
set -euo pipefail

echo "[20] Installing official packages with pacman..."

sudo pacman -Sy --needed --noconfirm \
  hyprland hyprpaper hypridle hyprlock \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  waybar mako wofi \
  networkmanager network-manager-applet networkmanager-dmenu \
  grim slurp swappy wl-clipboard \
  thunar thunar-volman tumbler \
  lf \
  zsh starship \
  papirus-icon-theme adw-gtk-theme \
  cliphist playerctl jq \
  flatpak \
  greetd greetd-tuigreet \
  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber \
  pavucontrol \
  bluez bluez-utils blueman

echo "[20] Installing packages from AUR with yay..."

yay -S --needed --noconfirm \
  ghostty \
  ttf-jetbrains-mono-nerd \
  lazygit \
  lazydocker \
  impala \
  bluetuith
