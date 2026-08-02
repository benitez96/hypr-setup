-- Floating windows
hl.window_rule({
    name  = "floating-window",
    match = { tag = "floating-window" },

    float  = true,
    center = true,
    size   = "875 600",
})

-- Apps installed by default that should float
hl.window_rule({
    name  = "tag-floating-apps",
    match = {
        class = "(org.hypr.bluetui|org.hypr.impala|org.hypr.wiremix|org.hypr.emit-double|org.hypr.btop|org.hypr.terminal|org.hypr.bash|org.gnome.NautilusPreviewer|org.gnome.Evince|com.gabm.satty|Hypr|About|TUI.float|imv|mpv)",
    },

    tag = "+floating-window",
})

hl.window_rule({
    name  = "tag-floating-file-dialogs",
    match = {
        class = "(xdg-desktop-portal-gtk|org.gnome.Nautilus)",
        title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
    },

    tag = "+floating-window",
})

hl.window_rule({
    name  = "float-calculator",
    match = { class = "org.gnome.Calculator" },

    float = true,
})

-- Fullscreen screensaver
hl.window_rule({
    name  = "screensaver",
    match = { class = "org.hypr.screensaver" },

    fullscreen = true,
    float      = true,
})

-- No transparency on media windows (only apps installed by default)
hl.window_rule({
    name  = "media-no-opacity",
    match = { class = "^(mpv|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$" },

    opacity = "1 1",
})

-- Popped window rounding
hl.window_rule({
    name  = "pop-rounding",
    match = { tag = "pop" },

    rounding = 10,
})

-- Prevent idle while open
hl.window_rule({
    name  = "noidle",
    match = { tag = "noidle" },

    idle_inhibit = "always",
})
