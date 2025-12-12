#!/usr/bin/env bash
set -euo pipefail

echo "[30] Habilitando servicios..."

sudo systemctl enable NetworkManager
sudo systemctl enable greetd

echo "[30] Servicios habilitados: NetworkManager, greetd."
