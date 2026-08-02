-- Chromium browser configuration
-- Only Chromium is installed by default
hl.window_rule({
    name  = "tag-chromium",
    match = { class = "^[cC]hrom(e|ium)$" },

    tag = "+chromium-based-browser",
})

-- Force chromium-based browsers into a tile to deal with --app bug
hl.window_rule({
    name  = "chromium-tile",
    match = { tag = "chromium-based-browser" },

    tile = true,
})

-- Only a subtle opacity change, but not for video sites
hl.window_rule({
    name  = "chromium-opacity",
    match = { tag = "chromium-based-browser" },

    opacity = "1 0.97",
})

-- Some video sites should never have opacity applied to them
hl.window_rule({
    name  = "youtube-no-opacity",
    match = { title = [[.*youtube\.com.*]] },

    opacity = "1.0 1.0",
})
