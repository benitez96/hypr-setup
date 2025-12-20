#!/usr/bin/env bash
set -euo pipefail

echo "[45] Setting up Walker and Elephant..."

# Enable and start Elephant service
if command -v elephant >/dev/null 2>&1; then
  elephant service enable || true
  systemctl --user enable --now elephant.service || true
fi

# Create autostart entry for Walker
mkdir -p "${HOME}/.config/autostart"
cat > "${HOME}/.config/autostart/walker.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Walker
Comment=Walker Service
Exec=walker --gapplication-service
StartupNotify=false
Terminal=false
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

echo "[45] Walker and Elephant configured."

