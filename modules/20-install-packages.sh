#!/usr/bin/env bash
set -euo pipefail

echo "[20] Installing official packages with pacman..."

sudo pacman -Sy --needed --noconfirm \
  hyprland hyprpaper hypridle hyprlock \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  waybar mako \
  networkmanager network-manager-applet networkmanager-dmenu \
  grim slurp wl-clipboard \
  thunar thunar-volman tumbler \
  lf \
  zsh starship \
  papirus-icon-theme adw-gtk-theme \
  cliphist playerctl jq \
  flatpak \
  greetd tuigreet \
  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber \
  bluez bluez-utils blueman \
  swayosd \
  xournalpp \
  imv

echo "[20] Installing packages from AUR with yay..."

yay -S --needed --noconfirm \
  ghostty \
  ttf-jetbrains-mono-nerd \
  lazygit \
  lazydocker \
  impala \
  bluetuith \
  walker-bin \
  elephant-bin
