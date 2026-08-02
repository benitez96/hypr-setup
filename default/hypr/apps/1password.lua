hl.window_rule({
    name  = "1password",
    match = { class = "^(1[p|P]assword)$" },

    no_screen_share = true,
    tag             = "+floating-window",
})
