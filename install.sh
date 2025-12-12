#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/benitez96/hypr-setup.git"
CLONE_DIR="${HOME}/.local/share/hypr-setup"

echo "[*] Verificando que estás en Arch..."
if ! grep -qi "ID=arch" /etc/os-release; then
  echo "[!] Esto está pensado para Arch Linux. Abortando."
  exit 1
fi

if [ ! -d "$CLONE_DIR" ]; then
  echo "[*] Clonando repo en $CLONE_DIR ..."
  mkdir -p "$(dirname "$CLONE_DIR")"
  git clone "$REPO_URL" "$CLONE_DIR"
else
  echo "[*] Repo ya existe en $CLONE_DIR, actualizando..."
  git -C "$CLONE_DIR" pull --ff-only
fi

cd "$CLONE_DIR"

echo "[*] Ejecutando módulos..."
for module in modules/*.sh; do
  echo "==> Ejecutando $(basename "$module")"
  bash "$module"
done

echo
echo "[✔] Instalación completada. Reinicia y logueate en Hyprland."
