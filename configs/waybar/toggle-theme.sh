#!/usr/bin/env bash
# Script para alternar entre tema claro y oscuro de Catppuccin

STYLE="$HOME/.config/waybar/style.css"
STYLE_LIGHT="$HOME/.config/waybar/style-light.css"
STYLE_DARK="$HOME/.config/waybar/style.css"

# Verificar si existe el archivo light
if [ ! -f "$STYLE_LIGHT" ]; then
    echo "Error: No se encontró style-light.css"
    exit 1
fi

# Verificar qué tema está activo
if [ -L "$STYLE" ]; then
    # Es un symlink, verificar a dónde apunta
    current=$(readlink "$STYLE")
    if [[ "$current" == *"style-light.css"* ]]; then
        # Cambiar a dark
        ln -sf "$STYLE_DARK" "$STYLE"
    else
        # Cambiar a light
        ln -sf "$STYLE_LIGHT" "$STYLE"
    fi
else
    # No es symlink, crear uno apuntando a light
    mv "$STYLE" "${STYLE}.backup" 2>/dev/null || true
    ln -sf "$STYLE_LIGHT" "$STYLE"
fi

# Recargar waybar
pkill -USR2 waybar || true

