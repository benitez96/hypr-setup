#!/usr/bin/env bash
set -euo pipefail

echo "[30] Enabling services..."

sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth

echo "[30] Services enabled: NetworkManager, bluetooth."
