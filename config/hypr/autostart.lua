-- Personal autostart and environment.
-- Defaults live in default/hypr/autostart.lua.

-- Zona horaria explícita: Brave/Chromium en sandbox a veces no la detecta solo
-- (Etc/Unknown)
hl.env("TZ", "America/Argentina/Buenos_Aires")

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Clipboard history daemon
    hl.exec_cmd("cliphist wipe")
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- Extra autostart processes
    -- hl.exec_cmd("uwsm-app -- my-service")
end)
