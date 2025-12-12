#!/usr/bin/env bash
set -euo pipefail

echo "[35] Configurando zsh + Starship (Catppuccin)..."

# Generar configuración de Starship con preset Catppuccin Powerline
mkdir -p "${HOME}/.config"
starship preset catppuccin-powerline -o "${HOME}/.config/starship.toml" || {
  echo "[35] WARNING: No se pudo aplicar el preset catppuccin-powerline."
  echo "     Verifica que la versión de starship soporta ese preset."
}

# Copiar .zshrc desde configs
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "${HOME}"
cp -f "${REPO_DIR}/configs/zsh/.zshrc" "${HOME}/.zshrc"

# Cambiar shell por defecto a zsh
if [ "$(basename "${SHELL}")" != "zsh" ]; then
  echo "[35] Cambiando shell por defecto a zsh para el usuario ${USER}..."
  chsh -s /usr/bin/zsh "${USER}" || echo "[35] No se pudo cambiar shell automáticamente, hazlo manual con: chsh -s /usr/bin/zsh"
fi

echo "[35] zsh + Starship configurados."
