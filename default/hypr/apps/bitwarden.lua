hl.window_rule({
    name  = "bitwarden",
    match = { class = "^(Bitwarden)$" },

    no_screen_share = true,
    tag             = "+floating-window",
})
