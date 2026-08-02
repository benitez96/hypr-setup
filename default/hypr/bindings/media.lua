-- Only display the OSD on the currently focused monitor
local osd = [[swayosd-client --monitor "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')"]]

local function osd_cmd(args)
    return hl.dsp.exec_cmd(osd .. " " .. args)
end

-- Laptop multimedia keys for volume and LCD brightness (with OSD)
hl.bind("XF86AudioRaiseVolume",  osd_cmd("--output-volume raise"),      { repeating = true, locked = true, desc = "Volume up" })
hl.bind("XF86AudioLowerVolume",  osd_cmd("--output-volume lower"),      { repeating = true, locked = true, desc = "Volume down" })
hl.bind("XF86AudioMute",         osd_cmd("--output-volume mute-toggle"), { repeating = true, locked = true, desc = "Mute" })
hl.bind("XF86AudioMicMute",      osd_cmd("--input-volume mute-toggle"),  { repeating = true, locked = true, desc = "Mute microphone" })
hl.bind("XF86MonBrightnessUp",   osd_cmd("--brightness raise"),          { repeating = true, locked = true, desc = "Brightness up" })
hl.bind("XF86MonBrightnessDown", osd_cmd("--brightness lower"),          { repeating = true, locked = true, desc = "Brightness down" })

-- Precise 1% multimedia adjustments with Alt modifier
hl.bind("ALT + XF86AudioRaiseVolume",  osd_cmd("--output-volume +1"), { repeating = true, locked = true, desc = "Volume up precise" })
hl.bind("ALT + XF86AudioLowerVolume",  osd_cmd("--output-volume -1"), { repeating = true, locked = true, desc = "Volume down precise" })
hl.bind("ALT + XF86MonBrightnessUp",   osd_cmd("--brightness +1"),    { repeating = true, locked = true, desc = "Brightness up precise" })
hl.bind("ALT + XF86MonBrightnessDown", osd_cmd("--brightness -1"),    { repeating = true, locked = true, desc = "Brightness down precise" })

-- Requires playerctl
hl.bind("XF86AudioNext",  osd_cmd("--playerctl next"),       { locked = true, desc = "Next track" })
hl.bind("XF86AudioPause", osd_cmd("--playerctl play-pause"), { locked = true, desc = "Pause" })
hl.bind("XF86AudioPlay",  osd_cmd("--playerctl play-pause"), { locked = true, desc = "Play" })
hl.bind("XF86AudioPrev",  osd_cmd("--playerctl previous"),   { locked = true, desc = "Previous track" })

-- Switch audio output with Super + Mute
hl.bind("SUPER + XF86AudioMute", hl.dsp.exec_cmd("cmd-audio-switch"), { locked = true, desc = "Switch audio output" })
