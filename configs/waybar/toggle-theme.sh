#!/usr/bin/env bash
STYLE="$HOME/.config/waybar/style.css"

if grep -q mocha "$STYLE"; then
    sed -i 's/mocha/latte/g' "$STYLE"
else
    sed -i 's/latte/mocha/g' "$STYLE"
fi

pkill -USR2 waybar
