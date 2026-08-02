-- Picture-in-picture overlays
hl.window_rule({
    name  = "tag-pip",
    match = { title = ".*[Pp]icture.*in.*[Pp]icture.*" },

    tag = "+pip",
})

hl.window_rule({
    name  = "pip",
    match = { tag = "pip" },

    float             = true,
    pin               = true,
    size              = "600 338",
    keep_aspect_ratio = true,
    decorate          = false,
    opacity           = "1 1",
    move              = "100%-w-40 4%",
})
