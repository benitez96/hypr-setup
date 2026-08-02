-- Workspace rules. See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Keep 1-5 around even when empty, so the bar always shows them.
-- This used to be waybar's "persistent-workspaces", but that option only exists
-- in its hyprland/workspaces module, which cannot switch workspaces under a Lua
-- config (it talks to Hyprland with the legacy IPC dispatch syntax). Doing it
-- here works with any bar.
for ws = 1, 5 do
    hl.workspace_rule({ workspace = tostring(ws), persistent = true })
end
