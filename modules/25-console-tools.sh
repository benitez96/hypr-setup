#!/usr/bin/env bash
set -euo pipefail

echo "[25] Installing console tools..."

sudo pacman -Sy --needed --noconfirm \
  zoxide fzf bat eza ripgrep fastfetch btop ghostscript fd
