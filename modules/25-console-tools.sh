#!/usr/bin/env bash
set -euo pipefail

echo "[25] Instalando herramientas de consola..."

sudo pacman -Sy --needed --noconfirm \
  zoxide fzf bat eza ripgrep fastfetch btop ghostscript fd
