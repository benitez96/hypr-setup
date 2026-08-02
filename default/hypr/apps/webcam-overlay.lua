-- Webcam overlay for screen recording
hl.window_rule({
    name  = "webcam-overlay",
    match = { title = "WebcamOverlay" },

    float            = true,
    pin              = true,
    no_initial_focus = true,
    no_dim           = true,

    -- There's a typo in the hyprland rule so 100%-w on the height param is actually correct here
    move = "100%-w-40 100%-w-40",
})
