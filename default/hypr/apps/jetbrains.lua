-- Fix splash screen showing in weird places and prevent annoying focus takeovers
hl.window_rule({
    name  = "tag-jetbrains-splash",
    match = { class = "^(jetbrains-.*)$", title = "^(splash)$", float = true },

    tag = "+jetbrains-splash",
})

hl.window_rule({
    name  = "jetbrains-splash",
    match = { tag = "jetbrains-splash" },

    center   = true,
    no_focus = true,
    decorate = false,
})

-- Center popups/find windows
hl.window_rule({
    name  = "tag-jetbrains",
    match = { class = "^(jetbrains-.*)", title = "^()$", float = true },

    tag = "+jetbrains",
})

-- stay_focused makes it possible to provide input in popup dialogs (search window, new file, etc.)
hl.window_rule({
    name  = "jetbrains",
    match = { tag = "jetbrains" },

    center       = true,
    stay_focused = true,
    decorate     = false,
})

-- For some reason tag:jetbrains does not work for the size rule
hl.window_rule({
    name  = "jetbrains-size",
    match = { class = "^(jetbrains-.*)", title = "^()$", float = true },

    size = ">50% >50%",
})

-- Disable window flicker when autocomplete or tooltips appear
hl.window_rule({
    name  = "jetbrains-no-initial-focus",
    match = { class = "^(jetbrains-.*)$", title = "^(win.*)$", float = true },

    no_initial_focus = true,
})

-- Disable mouse focus
hl.window_rule({
    name  = "jetbrains-no-follow-mouse",
    match = { class = "^(jetbrains-.*)$" },

    no_follow_mouse = true,
})
