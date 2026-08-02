-- kanagawa colors for Hyprland.
-- Not a full configuration: sourced through ~/.config/hypr/current/theme.
local activeBorderColor = "rgb(dcd7ba)"

hl.config({
    general = { col = { active_border = activeBorderColor } },
    group   = { col = { border_active = activeBorderColor } },
})

-- Kanagawa backdrop is too strong for the default opacity
hl.window_rule({
    name  = "kanagawa-terminal-opacity",
    match = { tag = "terminal" },

    opacity = "0.98 0.95",
})
