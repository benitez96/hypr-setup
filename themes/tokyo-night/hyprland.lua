-- tokyo-night colors for Hyprland.
-- Not a full configuration: sourced through ~/.config/hypr/current/theme.
local activeBorderColor = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 }

hl.config({
    general = { col = { active_border = activeBorderColor } },
    group   = { col = { border_active = activeBorderColor } },
})
