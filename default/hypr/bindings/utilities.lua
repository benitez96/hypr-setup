-- Menus
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("launch-rofi"), { desc = "Launch apps" })
hl.bind("SUPER + CTRL + E", hl.dsp.exec_cmd("launch-rofi -m emoji"), { desc = "Emoji picker" })
hl.bind("SUPER + ALT + SPACE", hl.dsp.exec_cmd("menu"), { desc = "Menu" })
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("menu system"), { desc = "System menu" })
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("menu system"), { locked = true, desc = "Power menu" })
hl.bind("SUPER + K", hl.dsp.exec_cmd("menu-keybindings"), { desc = "Show key bindings" })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("gnome-calculator"), { desc = "Calculator" })

-- Aesthetics
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd("toggle-waybar"), { desc = "Toggle top bar" })
hl.bind("SUPER + CTRL + SPACE", hl.dsp.exec_cmd("theme-bg-next"), { desc = "Next background in theme" })
hl.bind("SUPER + SHIFT + CTRL + SPACE", hl.dsp.exec_cmd("menu theme"), { desc = "Theme menu" })
hl.bind("SUPER + SHIFT + BACKSPACE", hl.dsp.exec_cmd("hyprland-workspace-toggle-gaps"), { desc = "Toggle workspace gaps" })

-- Toggle transparency on the focused window (no shelling out to hyprctl anymore)
hl.bind("SUPER + BACKSPACE", function()
    local window = hl.get_active_window()
    if window then
        hl.dispatch(hl.dsp.window.set_prop({ window = window, prop = "opaque", value = "toggle" }))
    end
end, { desc = "Toggle window transparency" })

-- Notifications
hl.bind("SUPER + COMMA", hl.dsp.exec_cmd("makoctl dismiss"), { desc = "Dismiss last notification" })
hl.bind("SUPER + SHIFT + COMMA", hl.dsp.exec_cmd("makoctl dismiss --all"), { desc = "Dismiss all notifications" })
hl.bind("SUPER + CTRL + COMMA",
    hl.dsp.exec_cmd([[makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb' && notify-send "Silenced notifications" || notify-send "Enabled notifications"]]),
    { desc = "Toggle silencing notifications" })
hl.bind("SUPER + ALT + COMMA", hl.dsp.exec_cmd("makoctl invoke"), { desc = "Invoke last notification" })
hl.bind("SUPER + SHIFT + ALT + COMMA", hl.dsp.exec_cmd("makoctl restore"), { desc = "Restore last notification" })

-- Toggle idling
hl.bind("SUPER + CTRL + I", hl.dsp.exec_cmd("toggle-idle"), { desc = "Toggle locking on idle" })

-- Toggle nightlight
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("toggle-nightlight"), { desc = "Toggle nightlight" })

-- Captures
hl.bind("PRINT", hl.dsp.exec_cmd("cmd-screenshot"), { desc = "Screenshot with editing" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("cmd-screenshot smart clipboard"), { desc = "Screenshot to clipboard" })
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("menu screenrecord"), { desc = "Screenrecording" })
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { desc = "Color picker" })

-- File sharing
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd("menu share"), { desc = "Share" })

-- Waybar-less information
hl.bind("SUPER + CTRL + T",
    hl.dsp.exec_cmd([[notify-send "    $(date +"%A %H:%M  —  %d %B W%V %Y")"]]),
    { desc = "Show time" })
hl.bind("SUPER + CTRL + B",
    hl.dsp.exec_cmd([[notify-send "󰁹    Battery is at $(battery-remaining)%"]]),
    { desc = "Show battery remaining" })
