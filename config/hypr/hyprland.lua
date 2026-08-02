-- Hyprland configuration (Lua format, required from Hyprland 0.57 on).
--
-- This file is the entrypoint. It lives in the repo
-- (~/.local/share/hypr/config/hypr/hyprland.lua) and ~/.config/hypr/hyprland.lua
-- is only a symlink to it, so the whole setup stays in git and is replicable.
--
-- Load order (later wins):
--   1. defaults    ~/.local/share/hypr/default/hypr/**
--   2. theme       ~/.config/hypr/current/theme/hyprland.lua
--   3. your config ~/.local/share/hypr/config/hypr/*.lua

local setup = os.getenv("HOME") .. "/.local/share/hypr"
local L = assert(loadfile(setup .. "/default/hypr/lib/loader.lua"))()

-- 1. Hypr Setup defaults (don't edit those directly, override them below)
L.source("default/hypr/init.lua")

-- 2. Colors from the active theme (see bin/theme-set)
L.source_optional("~/.config/hypr/current/theme/hyprland.lua")

-- 3. Personal configuration
L.source_all({
    "config/hypr/monitors.lua",
    "config/hypr/input.lua",
    "config/hypr/bindings.lua",
    "config/hypr/looknfeel.lua",
    "config/hypr/autostart.lua",
})
