-- hackerman colors for Hyprland.
-- Not a full configuration: sourced through ~/.config/hypr/current/theme.
local activeBorderColor = { colors = { "rgba(26a269ee)", "rgba(2ec27eee)" }, angle = 45 }

hl.config({
    general = { col = { active_border = activeBorderColor } },
    group   = { col = { border_active = activeBorderColor } },
})
