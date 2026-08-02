-- Copy / Paste
hl.bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }),  { desc = "Universal copy" })
hl.bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }), { desc = "Universal paste" })
hl.bind("SUPER + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }),       { desc = "Universal cut" })

hl.bind("SUPER + CTRL + V", hl.dsp.exec_cmd("launch-rofi -m clipboard"), { desc = "Clipboard manager" })
