#!/usr/bin/env bash
set -euo pipefail

YAY_DIR="${HOME}/.local/src/yay"

if command -v yay >/dev/null 2>&1; then
  echo "[10] yay is already installed, skipping..."
  exit 0
fi

echo "[10] Installing yay (AUR helper)..."
mkdir -p "$YAY_DIR"
if [ ! -d "$YAY_DIR/.git" ]; then
  git clone https://aur.archlinux.org/yay.git "$YAY_DIR"
else
  git -C "$YAY_DIR" pull --ff-only
fi

cd "$YAY_DIR"
makepkg -si --noconfirm
