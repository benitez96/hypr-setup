#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[40] Deploying configurations to ~/.config and ~/.local/bin..."

# Hyprland
mkdir -p "${HOME}/.config/hypr"
cp -f "${REPO_DIR}/configs/hypr/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
cp -f "${REPO_DIR}/configs/hypr/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"
cp -f "${REPO_DIR}/configs/hypr/autostart.conf" "${HOME}/.config/hypr/autostart.conf"
cp -f "${REPO_DIR}/configs/hypr/input.conf" "${HOME}/.config/hypr/input.conf"
cp -f "${REPO_DIR}/configs/hypr/looknfeel.conf" "${HOME}/.config/hypr/looknfeel.conf"
cp -f "${REPO_DIR}/configs/hypr/bindings.conf" "${HOME}/.config/hypr/bindings.conf"
cp -f "${REPO_DIR}/configs/hypr/monitors.conf" "${HOME}/.config/hypr/monitors.conf"
cp -f "${REPO_DIR}/configs/hypr/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
cp -f "${REPO_DIR}/configs/hypr/hypridle.conf" "${HOME}/.config/hypr/hypridle.conf"

# Wallpapers
mkdir -p "${HOME}/Pictures/Wallpapers"
if [ -f "${REPO_DIR}/configs/wallpapers/pink_lakeside.png" ]; then
  cp -f "${REPO_DIR}/configs/wallpapers/pink_lakeside.png" "${HOME}/Pictures/Wallpapers/pink_lakeside.png"
fi

# Waybar
mkdir -p "${HOME}/.config/waybar"
mkdir -p "${HOME}/.config/waybar/scripts"
cp -f "${REPO_DIR}/configs/waybar/config.jsonc" "${HOME}/.config/waybar/config.jsonc"
cp -f "${REPO_DIR}/configs/waybar/style.css" "${HOME}/.config/waybar/style.css"
cp -f "${REPO_DIR}/configs/waybar/style-light.css" "${HOME}/.config/waybar/style-light.css"
cp -f "${REPO_DIR}/configs/waybar/toggle-theme.sh" "${HOME}/.config/waybar/toggle-theme.sh"
cp -f "${REPO_DIR}/configs/waybar/scripts/check-updates.sh" "${HOME}/.config/waybar/scripts/check-updates.sh"
chmod +x "${HOME}/.config/waybar/toggle-theme.sh"
chmod +x "${HOME}/.config/waybar/scripts/check-updates.sh"

# Mako
mkdir -p "${HOME}/.config/mako"
cp -f "${REPO_DIR}/configs/mako/config" "${HOME}/.config/mako/config"


# Wofi
mkdir -p "${HOME}/.config/wofi"
cp -f "${REPO_DIR}/configs/wofi/config"    "${HOME}/.config/wofi/config"
cp -f "${REPO_DIR}/configs/wofi/style.css" "${HOME}/.config/wofi/style.css"

# Scripts in ~/.local/bin
mkdir -p "${HOME}/.local/bin"
cp -f "${REPO_DIR}/configs/bin/menu-main"        "${HOME}/.local/bin/menu-main"
cp -f "${REPO_DIR}/configs/bin/menu-screenshots" "${HOME}/.local/bin/menu-screenshots"
cp -f "${REPO_DIR}/configs/bin/menu-system"      "${HOME}/.local/bin/menu-system"
cp -f "${REPO_DIR}/configs/bin/menu-windows"     "${HOME}/.local/bin/menu-windows"
cp -f "${REPO_DIR}/configs/bin/menu-clipboard"   "${HOME}/.local/bin/menu-clipboard"
cp -f "${REPO_DIR}/configs/bin/menu-utilities"   "${HOME}/.local/bin/menu-utilities"

chmod +x "${HOME}/.local/bin/"{menu-main,menu-screenshots,menu-system,menu-windows,menu-clipboard,menu-utilities}

# Binary scripts (screenshot and PDF helpers)
mkdir -p "${HOME}/.local/bin"
cp -f "${REPO_DIR}/configs/bin/screenshot" "${HOME}/.local/bin/screenshot"
cp -f "${REPO_DIR}/configs/bin/pdfcompress-low" "${HOME}/.local/bin/pdfcompress-low"
cp -f "${REPO_DIR}/configs/bin/pdfcompress-medium" "${HOME}/.local/bin/pdfcompress-medium"
cp -f "${REPO_DIR}/configs/bin/pdfmerge" "${HOME}/.local/bin/pdfmerge"
chmod +x "${HOME}/.local/bin/screenshot"
chmod +x "${HOME}/.local/bin/pdfcompress-low"
chmod +x "${HOME}/.local/bin/pdfcompress-medium"
chmod +x "${HOME}/.local/bin/pdfmerge"

# System scripts (updates, wifi, bluetooth, webapp, battery)
cp -f "${REPO_DIR}/configs/bin/check-updates" "${HOME}/.local/bin/check-updates"
cp -f "${REPO_DIR}/configs/bin/system-update" "${HOME}/.local/bin/system-update"
cp -f "${REPO_DIR}/configs/bin/launch-wifi" "${HOME}/.local/bin/launch-wifi"
cp -f "${REPO_DIR}/configs/bin/launch-bluetooth" "${HOME}/.local/bin/launch-bluetooth"
cp -f "${REPO_DIR}/configs/bin/launch-webapp" "${HOME}/.local/bin/launch-webapp"
cp -f "${REPO_DIR}/configs/bin/webapp-install" "${HOME}/.local/bin/webapp-install"
cp -f "${REPO_DIR}/configs/bin/launch-or-focus-tui" "${HOME}/.local/bin/launch-or-focus-tui"
cp -f "${REPO_DIR}/configs/bin/battery-remaining" "${HOME}/.local/bin/battery-remaining"
cp -f "${REPO_DIR}/configs/bin/battery-monitor" "${HOME}/.local/bin/battery-monitor"
cp -f "${REPO_DIR}/configs/bin/lock-screen" "${HOME}/.local/bin/lock-screen"
chmod +x "${HOME}/.local/bin/"{check-updates,system-update,launch-wifi,launch-bluetooth,launch-webapp,webapp-install,launch-or-focus-tui,battery-remaining,battery-monitor,lock-screen}

# greetd (requires sudo)
echo "[40] Configuring greetd (requires sudo)..."
sudo mkdir -p /etc/greetd
sudo cp -f "${REPO_DIR}/configs/greetd/config.toml" /etc/greetd/config.toml

echo "[40] Configurations deployed."
