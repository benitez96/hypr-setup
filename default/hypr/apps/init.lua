-- App-specific tweaks.
-- Only apps installed by default are enabled here; uncomment the rest as needed.
local L = ...

-- Core apps (installed by default)
L.source_all({
    "default/hypr/apps/browser.lua",
    "default/hypr/apps/hyprshot.lua",
    "default/hypr/apps/pip.lua",
    "default/hypr/apps/system.lua",
    "default/hypr/apps/terminals.lua",
})

-- Optional apps (uncomment if you install them)
L.source_all({
    -- "default/hypr/apps/1password.lua",
    -- "default/hypr/apps/bitwarden.lua",
    -- "default/hypr/apps/jetbrains.lua",
    -- "default/hypr/apps/localsend.lua",
    -- "default/hypr/apps/qemu.lua",
    -- "default/hypr/apps/webcam-overlay.lua",
    -- "default/hypr/apps/davinci-resolve.lua",
})
