-- Deprecated pre-v2 keymap, kept for anyone who does not want the newer hotkeys.
-- Not sourced by default: swap it for tiling-v2.lua in bindings/init.lua to use it.

local directions = {
    LEFT  = "left",
    RIGHT = "right",
    UP    = "up",
    DOWN  = "down",
}

-- See tiling-v2.lua: "code:NN" keys do not survive Hyprland 0.56's Lua parser.
local number_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local minus_key, equal_key = "minus", "equal"

-- Close windows
hl.bind("SUPER + W", hl.dsp.window.close(), { desc = "Close window" })
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprland-window-close-all"), { desc = "Close all windows" })

-- Control tiling
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { desc = "Toggle window split" })
hl.bind("SUPER + P", hl.dsp.window.pseudo(), { desc = "Pseudo window" })
hl.bind("SUPER + SHIFT + V", hl.dsp.window.float({ action = "toggle" }), { desc = "Toggle window floating/tiling" })
hl.bind("SHIFT + F11", hl.dsp.window.fullscreen(0), { desc = "Force full screen" })
hl.bind("ALT + F11", hl.dsp.window.fullscreen(1), { desc = "Full width" })

-- Move focus with SUPER + arrow keys
for key, dir in pairs(directions) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }), { desc = "Move focus " .. dir })
end

-- Workspaces on SUPER + [1-9; 0]
for ws = 1, 10 do
    local key = number_keys[ws]
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = ws }), { desc = "Switch to workspace " .. ws })
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }), { desc = "Move window to workspace " .. ws })
end

-- TAB between workspaces
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }), { desc = "Next workspace" })
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), { desc = "Previous workspace" })
hl.bind("SUPER + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }), { desc = "Former workspace" })

-- Swap active window with the one next to it
for key, dir in pairs(directions) do
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }), { desc = "Swap window " .. dir })
end

-- Cycle through applications on active workspace
hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { desc = "Cycle to next window" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ prev = true }), { desc = "Cycle to prev window" })
hl.bind("ALT + TAB", hl.dsp.window.bring_to_top(), { desc = "Reveal active window on top" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.bring_to_top(), { desc = "Reveal active window on top" })

-- Resize active window
hl.bind("SUPER + " .. minus_key, hl.dsp.window.resize({ x = -100, y = 0 }), { desc = "Expand window left" })
hl.bind("SUPER + " .. equal_key, hl.dsp.window.resize({ x = 100, y = 0 }), { desc = "Shrink window left" })
hl.bind("SUPER + SHIFT + " .. minus_key, hl.dsp.window.resize({ x = 0, y = -100 }), { desc = "Shrink window up" })
hl.bind("SUPER + SHIFT + " .. equal_key, hl.dsp.window.resize({ x = 0, y = 100 }), { desc = "Expand window down" })

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { desc = "Scroll active workspace forward" })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { desc = "Scroll active workspace backward" })

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { drag = true, desc = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { drag = true, desc = "Resize window" })
