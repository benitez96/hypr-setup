-- Change the default Hypr Setup look'n'feel.
-- Anything set here overrides default/hypr/looknfeel.lua.

hl.config({
    -- https://wiki.hypr.land/Configuring/Variables/#general
    general = {
        -- No gaps between windows or borders
        -- gaps_in     = 0,
        -- gaps_out    = 0,
        -- border_size = 0,

        -- Use master layout instead of dwindle
        -- layout = "master",
    },

    -- https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration = {
        -- Use round window corners
        -- rounding = 8,
    },

    -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        -- Avoid overly wide single-window layouts on wide screens
        -- single_window_aspect_ratio = "1 1",
    },
})
