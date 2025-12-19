#!/usr/bin/env bash
set -euo pipefail

echo "[00] Installing prerequisites (git, base-devel)..."
sudo pacman -Sy --needed --noconfirm git base-devel
