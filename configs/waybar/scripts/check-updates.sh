#!/usr/bin/env bash
# Script for waybar that checks updates and returns JSON

pacman_updates=$(pacman -Qu 2>/dev/null | wc -l)
aur_updates=0
flatpak_updates=0

# Check AUR updates if yay is available
if command -v yay &> /dev/null; then
    aur_updates=$(yay -Qua 2>/dev/null | wc -l)
fi

# Check flatpak updates if flatpak is available
if command -v flatpak &> /dev/null; then
    flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null | wc -l)
fi

total_updates=$((pacman_updates + aur_updates + flatpak_updates))

if [ "$total_updates" -gt 0 ]; then
    tooltip="Updates: $total_updates (pacman: $pacman_updates"
    if [ "$aur_updates" -gt 0 ]; then
        tooltip="$tooltip, AUR: $aur_updates"
    fi
    if [ "$flatpak_updates" -gt 0 ]; then
        tooltip="$tooltip, flatpak: $flatpak_updates"
    fi
    tooltip="$tooltip)"
    echo "{\"text\": \"󰏕 $total_updates\", \"tooltip\": \"$tooltip\", \"class\": \"update-available\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"System up to date\"}"
fi

