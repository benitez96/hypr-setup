#!/usr/bin/env bash
set -euo pipefail

echo "[35] Configuring zsh + Starship (Catppuccin)..."

# Generate Starship configuration with Catppuccin Powerline preset
mkdir -p "${HOME}/.config"
starship preset catppuccin-powerline -o "${HOME}/.config/starship.toml" || {
  echo "[35] WARNING: Could not apply catppuccin-powerline preset."
  echo "     Verify that your starship version supports this preset."
}

# Copy .zshrc from configs
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "${HOME}"
cp -f "${REPO_DIR}/configs/zsh/.zshrc" "${HOME}/.zshrc"

# Change default shell to zsh
if [ "$(basename "${SHELL}")" != "zsh" ]; then
  echo "[35] Changing default shell to zsh for user ${USER}..."
  chsh -s /usr/bin/zsh "${USER}" || echo "[35] Could not change shell automatically, do it manually with: chsh -s /usr/bin/zsh"
fi

echo "[35] zsh + Starship configured."
