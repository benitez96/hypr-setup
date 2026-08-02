-- Define terminal tag to style them uniformly
hl.window_rule({
    name  = "tag-terminal",
    match = { class = "(Alacritty|kitty|com.mitchellh.ghostty)" },

    tag = "+terminal",
})
