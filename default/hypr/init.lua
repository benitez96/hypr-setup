-- Hypr Setup defaults. Don't edit these directly -- override them from
-- ~/.config/hypr/*.lua instead, which is sourced after this file.
local L = ...

L.source_all({
    "default/hypr/envs.lua",
    "default/hypr/autostart.lua",
    "default/hypr/input.lua",
    "default/hypr/looknfeel.lua",
    "default/hypr/windows.lua",
    "default/hypr/bindings/init.lua",
})
