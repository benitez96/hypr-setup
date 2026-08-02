-- Personal keybindings. These are loaded after the defaults in
-- default/hypr/bindings/, so anything here is added on top of them.
--
-- To *replace* a default binding, unbind it first:
--     hl.unbind("SUPER + SPACE")
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("menu"), { desc = "Menu" })
--
-- Monitor bindings (SUPER + SHIFT + M) live in monitors.lua.

-- Rescue terminal: absolute path, no uwsm and no PATH lookup, so it still works
-- if the session comes up with a broken environment.
hl.bind("SUPER + CTRL + RETURN", hl.dsp.exec_cmd("/usr/bin/ghostty"), { desc = "Terminal (rescue)" })

-- Application bindings
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd([[uwsm-app -- xdg-terminal-exec --dir="$(cmd-terminal-cwd)"]]), { desc = "Terminal" })
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("uwsm-app -- keepassxc"), { desc = "Keepass" })
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd([[launch-tui opencode "$(cmd-terminal-cwd)"]]), { desc = "Opencode" })
hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm-app -- nautilus --new-window"), { desc = "File manager" })
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("launch-browser --private"), { desc = "Browser (private)" })
hl.bind("SUPER + B", hl.dsp.exec_cmd("launch-browser --public"), { desc = "Browser" })
hl.bind("SUPER + N", hl.dsp.exec_cmd("launch-editor"), { desc = "Editor" })
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("launch-tui btop"), { desc = "Activity" })
hl.bind("SUPER + I", hl.dsp.exec_cmd("launch-tui impala"), { desc = "Wifi" })
hl.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd("launch-tui bluetui"), { desc = "Bluetooth" })
hl.bind("SUPER + D", hl.dsp.exec_cmd("launch-tui lazydocker"), { desc = "Docker" })
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("cmd-screenshot"), { desc = "Screenshot" })

-- Web apps
hl.bind("SUPER + A", hl.dsp.exec_cmd("launch-webapp https://chatgpt.com"), { desc = "ChatGPT" })
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("launch-webapp https://grok.com"), { desc = "Grok" })
hl.bind("SUPER + Y", hl.dsp.exec_cmd("launch-webapp https://youtube.com/"), { desc = "YouTube" })
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("launch-or-focus-webapp WhatsApp https://web.whatsapp.com/"), { desc = "WhatsApp" })

-- SUPER + X is already taken by "Universal cut" (default/hypr/bindings/clipboard.lua),
-- so this X binding never fired. Uncomment both lines to claim the key instead:
-- hl.unbind("SUPER + X")
-- hl.bind("SUPER + X", hl.dsp.exec_cmd("launch-webapp https://x.com/"), { desc = "X" })
