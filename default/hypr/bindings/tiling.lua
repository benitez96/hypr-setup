-- Tiling keymap.

local directions = {
    LEFT  = "left",
    RIGHT = "right",
    UP    = "up",
    DOWN  = "down",
}

-- The .conf version bound these by keycode (code:10 .. code:21) to stay layout
-- independent. Hyprland 0.56's Lua parser accepts "code:NN" but silently ends up
-- with an empty key, so the bind never fires -- verified with `hyprctl binds` on
-- a nested instance. Keysyms it is; with kb_layout = us these are the very same
-- physical keys.
local number_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local minus_key, equal_key = "minus", "equal"

-- Close windows
hl.bind("SUPER + W", hl.dsp.window.close(), { desc = "Close window" })
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprland-window-close-all"), { desc = "Close all windows" })

-- Control tiling
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"), { desc = "Toggle window split" })         -- dwindle
hl.bind("SUPER + P", hl.dsp.window.pseudo(), { desc = "Pseudo window" })                      -- dwindle
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }), { desc = "Toggle window floating/tiling" })
hl.bind("SUPER + F", hl.dsp.window.fullscreen(0), { desc = "Full screen" })
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }), { desc = "Tiled full screen" })
hl.bind("SUPER + ALT + F", hl.dsp.window.fullscreen(1), { desc = "Full width" })
hl.bind("SUPER + O", hl.dsp.exec_cmd("hyprland-window-pop"), { desc = "Pop window out (float & pin)" })

-- Move focus with SUPER + arrow keys
for key, dir in pairs(directions) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }), { desc = "Move window focus " .. dir })
end

-- Workspaces on SUPER + [1-9; 0]
for ws = 1, 10 do
    local key = number_keys[ws]

    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = ws }),
        { desc = "Switch to workspace " .. ws })

    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }),
        { desc = "Move window to workspace " .. ws })

    hl.bind("SUPER + SHIFT + ALT + " .. key, hl.dsp.window.move({ workspace = ws, silent = true }),
        { desc = "Move window silently to workspace " .. ws })
end

-- Control scratchpad
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"), { desc = "Toggle scratchpad" })
hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:scratchpad", silent = true }),
    { desc = "Move window to scratchpad" })

-- TAB between workspaces
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }), { desc = "Next workspace" })
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), { desc = "Previous workspace" })
hl.bind("SUPER + CTRL + TAB", hl.dsp.focus({ workspace = "previous" }), { desc = "Former workspace" })

-- Move workspaces to other monitors
hl.bind("SUPER + SHIFT + ALT + LEFT", hl.dsp.workspace.move({ monitor = "l" }), { desc = "Move workspace to left monitor" })
hl.bind("SUPER + SHIFT + ALT + RIGHT", hl.dsp.workspace.move({ monitor = "r" }), { desc = "Move workspace to right monitor" })

-- Swap active window with the one next to it with SUPER + SHIFT + arrow keys
for key, dir in pairs(directions) do
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.swap({ direction = dir }), { desc = "Swap window " .. dir })
end

-- Cycle through applications on active workspace
hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { desc = "Cycle to next window" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({ prev = true }), { desc = "Cycle to prev window" })
hl.bind("ALT + TAB", hl.dsp.window.bring_to_top(), { desc = "Reveal active window on top" })
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.bring_to_top(), { desc = "Reveal active window on top" })

-- Resize active window with the "-" and "=" keys.
-- `relative = true` is what makes x/y a delta; without it they are read as an
-- absolute size and a negative value fails at runtime with "Invalid size".
hl.bind("SUPER + " .. minus_key, hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { desc = "Expand window left" })
hl.bind("SUPER + " .. equal_key, hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { desc = "Shrink window left" })
hl.bind("SUPER + SHIFT + " .. minus_key, hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { desc = "Shrink window up" })
hl.bind("SUPER + SHIFT + " .. equal_key, hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { desc = "Expand window down" })

-- Scroll through existing workspaces with SUPER + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { desc = "Scroll active workspace forward" })
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { desc = "Scroll active workspace backward" })

-- Move/resize windows with SUPER + LMB/RMB and dragging (the old bindm).
-- `mouse` is missing from the generated stub but the binary does parse it
-- ("hl.bind: mouse is exclusive"), and it is what Hyprland's own example config
-- uses. `drag` is a different thing -- fire on a drag gesture -- and made this
-- trigger only sometimes.
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, desc = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Resize window" })

-- Toggle groups
hl.bind("SUPER + G", hl.dsp.group.toggle(), { desc = "Toggle window grouping" })
hl.bind("SUPER + ALT + G", hl.dsp.group.move_window({ out = true }), { desc = "Move active window out of group" })

-- Join groups
for key, dir in pairs(directions) do
    hl.bind("SUPER + ALT + " .. key, hl.dsp.group.move_window({ direction = dir }),
        { desc = "Move window to group on " .. dir })
end

-- Navigate a single set of grouped windows
hl.bind("SUPER + ALT + TAB", hl.dsp.group.next(), { desc = "Next window in group" })
hl.bind("SUPER + ALT + SHIFT + TAB", hl.dsp.group.prev(), { desc = "Previous window in group" })

-- Window navigation for grouped windows
hl.bind("SUPER + CTRL + LEFT", hl.dsp.group.prev(), { desc = "Move grouped window focus left" })
hl.bind("SUPER + CTRL + RIGHT", hl.dsp.group.next(), { desc = "Move grouped window focus right" })

-- Scroll through a set of grouped windows with SUPER + ALT + scroll
hl.bind("SUPER + ALT + mouse_down", hl.dsp.group.next(), { desc = "Next window in group" })
hl.bind("SUPER + ALT + mouse_up", hl.dsp.group.prev(), { desc = "Previous window in group" })

-- Activate window in a group by number
for i = 1, 5 do
    hl.bind("SUPER + ALT + " .. number_keys[i], hl.dsp.group.active({ index = i }),
        { desc = "Switch to group window " .. i })
end
