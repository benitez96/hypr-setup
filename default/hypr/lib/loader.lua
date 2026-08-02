-- Tiny module loader for the Lua config tree.
--
-- Why not require()? require() caches modules in package.loaded, so a config
-- reload could skip re-running them. source() always re-executes the file,
-- which is exactly what the old `source = ...` keyword did.
--
-- Every sourced file receives this loader as its vararg:
--     local L = ...
--     L.source("default/hypr/envs.lua")

local loader = {}

loader.home  = os.getenv("HOME")
loader.setup = os.getenv("HYPR_SETUP_PATH")

-- HYPR_SETUP_PATH is set by Hyprland itself (see default/hypr/envs.lua), so it
-- is not guaranteed to be readable while the config is still being parsed.
if not loader.setup or loader.setup == "" or loader.setup:sub(1, 1) == "~" then
    loader.setup = loader.home .. "/.local/share/hypr"
end

loader.config = loader.home .. "/.config/hypr"

-- Absolute paths are used as-is, everything else is relative to the repo root.
function loader.path(p)
    if p:sub(1, 1) == "/" then return p end
    if p:sub(1, 2) == "~/" then return loader.home .. p:sub(2) end
    return loader.setup .. "/" .. p
end

-- Load and run a config file. Missing files are a hard error.
function loader.source(p)
    local full = loader.path(p)
    local chunk, err = loadfile(full)
    if not chunk then
        error("hypr config: cannot load " .. full .. ": " .. tostring(err), 0)
    end
    return chunk(loader)
end

-- Same, but a missing file is fine (user overrides, active theme, ...).
function loader.source_optional(p)
    local full = loader.path(p)
    if not loader.exists(full) then
        print("[hypr-setup] skipping missing config: " .. full)
        return nil
    end
    return loader.source(full)
end

-- Source several files in order.
function loader.source_all(paths)
    for _, p in ipairs(paths) do loader.source(p) end
end

function loader.source_all_optional(paths)
    for _, p in ipairs(paths) do loader.source_optional(p) end
end

function loader.exists(p)
    local f = io.open(p, "r")
    if f then f:close() return true end
    return false
end

-- Runtime state that has to survive a config reload (e.g. whether the internal
-- display is toggled off) lives in ~/.local/state/hypr/<name>.
local state_dir = loader.home .. "/.local/state/hypr"

-- Read a single-line state file. Returns nil when the file does not exist.
function loader.read_state(name)
    local f = io.open(state_dir .. "/" .. name, "r")
    if not f then return nil end
    local value = f:read("l")
    f:close()
    if value then value = value:match("^%s*(.-)%s*$") end
    if value == "" then return nil end
    return value
end

function loader.write_state(name, value)
    os.execute("mkdir -p '" .. state_dir .. "'")
    local f = io.open(state_dir .. "/" .. name, "w")
    if not f then
        print("[hypr-setup] could not write state: " .. name)
        return false
    end
    f:write(tostring(value), "\n")
    f:close()
    return true
end

return loader
