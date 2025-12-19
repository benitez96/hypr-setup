#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[40] Deploy de configuraciones a ~/.config y ~/.local/bin..."

# Hyprland
mkdir -p "${HOME}/.config/hypr"
cp -f "${REPO_DIR}/configs/hypr/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
cp -f "${REPO_DIR}/configs/hypr/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"

# Wallpapers
mkdir -p "${HOME}/Pictures/Wallpapers"
if [ -f "${REPO_DIR}/configs/wallpapers/pink_lakeside.png" ]; then
  cp -f "${REPO_DIR}/configs/wallpapers/pink_lakeside.png" "${HOME}/Pictures/Wallpapers/pink_lakeside.png"
fi

# Waybar
mkdir -p "${HOME}/.config/waybar"
cp -f "${REPO_DIR}/configs/waybar/config.jsonc" "${HOME}/.config/waybar/config.jsonc"
cp -f "${REPO_DIR}/configs/waybar/style.css" "${HOME}/.config/waybar/style.css"
cp -f "${REPO_DIR}/configs/waybar/toggle-theme.sh" "${HOME}/.config/waybar/toggle-theme.sh"
chmod +x "${HOME}/.config/waybar/toggle-theme.sh"

# Mako
mkdir -p "${HOME}/.config/mako"
cp -f "${REPO_DIR}/configs/mako/config" "${HOME}/.config/mako/config"


# Wofi
mkdir -p "${HOME}/.config/wofi"
cp -f "${REPO_DIR}/configs/wofi/config"    "${HOME}/.config/wofi/config"
cp -f "${REPO_DIR}/configs/wofi/style.css" "${HOME}/.config/wofi/style.css"

# Scripts en ~/.local/bin
mkdir -p "${HOME}/.local/bin"
cp -f "${REPO_DIR}/configs/bin/menu-main"        "${HOME}/.local/bin/menu-main"
cp -f "${REPO_DIR}/configs/bin/menu-screenshots" "${HOME}/.local/bin/menu-screenshots"
cp -f "${REPO_DIR}/configs/bin/menu-system"      "${HOME}/.local/bin/menu-system"
cp -f "${REPO_DIR}/configs/bin/menu-windows"     "${HOME}/.local/bin/menu-windows"
cp -f "${REPO_DIR}/configs/bin/menu-clipboard"   "${HOME}/.local/bin/menu-clipboard"
cp -f "${REPO_DIR}/configs/bin/menu-utilities"   "${HOME}/.local/bin/menu-utilities"

chmod +x "${HOME}/.local/bin/"{screenshot,menu-main,menu-screenshots,menu-system,menu-windows,menu-clipboard,menu-utilities}

# Scripts binarios (screenshot y PDF helpers)
mkdir -p "${HOME}/.local/bin"
cp -f "${REPO_DIR}/configs/bin/screenshot" "${HOME}/.local/bin/screenshot"
cp -f "${REPO_DIR}/configs/bin/pdfcompress-low" "${HOME}/.local/bin/pdfcompress-low"
cp -f "${REPO_DIR}/configs/bin/pdfcompress-medium" "${HOME}/.local/bin/pdfcompress-medium"
cp -f "${REPO_DIR}/configs/bin/pdfmerge" "${HOME}/.local/bin/pdfmerge"
chmod +x "${HOME}/.local/bin/screenshot"
chmod +x "${HOME}/.local/bin/pdfcompress-low"
chmod +x "${HOME}/.local/bin/pdfcompress-medium"
chmod +x "${HOME}/.local/bin/pdfmerge"

# greetd (requiere sudo)
echo "[40] Configurando greetd (requiere sudo)..."
sudo mkdir -p /etc/greetd
sudo cp -f "${REPO_DIR}/configs/greetd/config.toml" /etc/greetd/config.toml

echo "[40] Clonando tema Catppuccin para Waybar..."
if [ ! -d "${HOME}/.config/waybar/catppuccin" ]; then
  git clone https://github.com/catppuccin/waybar "${HOME}/.config/waybar/catppuccin"
else
  git -C "${HOME}/.config/waybar/catppuccin" pull --ff-only || true
fi

echo "[40] Configuraciones desplegadas."
