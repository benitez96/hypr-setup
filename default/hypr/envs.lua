local home = os.getenv("HOME")

-- Cursor size
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Allow better support for screen sharing (Google Meet, Discord, etc)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Use XCompose file
hl.env("XCOMPOSEFILE", home .. "/.XCompose")

-- Hypr Setup path (used by scripts)
local setup_bin = home .. "/.local/share/hypr/bin"

hl.env("HYPR_SETUP_PATH", home .. "/.local/share/hypr")

-- Compose PATH here instead of writing "$PATH": hyprlang expanded that, Lua
-- would set it literally and every spawned process (waybar, mako, swaybg, ...)
-- would lose /usr/bin.
local path = os.getenv("PATH") or "/usr/local/bin:/usr/bin:/bin"

if not (":" .. path .. ":"):find(":" .. setup_bin .. ":", 1, true) then
    path = setup_bin .. ":" .. path
end

hl.env("PATH", path)

-- Don't show update on first launch
hl.config({
    ecosystem = {
        no_update_news = true,
    },
})
