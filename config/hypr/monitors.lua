-- Monitors. See https://wiki.hypr.land/Configuring/Basics/Monitors/
local L = ...

-- Monitors are matched by *description*, not by connector name: the ultrawide
-- enumerates as DP-2 or DP-3 depending on hotplug/dock order, which is why the
-- old `monitor = DP-2, ...` rule silently stopped applying and the screen fell
-- back to defaults. Descriptions come from `hyprctl monitors all`.
local internal = {
    desc     = "AU Optronics 0x48B0", -- built-in laptop panel
    mode     = "2240x1400@60",
    position = "auto",
    scale    = "auto",
}

local external = {
    desc     = "Samsung Electric Company S34CG50", -- ultrawide 34"
    mode     = "3440x1440@60",
    position = "auto",
    scale    = 1,
}

-- Disable the laptop panel automatically while the ultrawide is connected.
-- Set to true if you never want the "phantom space" of the open laptop next to
-- the ultrawide; SUPER + SHIFT + M still overrides it manually either way.
local AUTO_DISABLE_INTERNAL_WHEN_DOCKED = false

--------------------------------------------------------------------------------
-- Monitor rules
--------------------------------------------------------------------------------

-- Fallback for anything not listed below (projectors, a new external, ...)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

local function rule(m)
    return { output = "desc:" .. m.desc, mode = m.mode, position = m.position, scale = m.scale }
end

hl.monitor(rule(external))
hl.monitor(rule(internal))

hl.env("GDK_SCALE", "1")

--------------------------------------------------------------------------------
-- Internal display toggle (SUPER + SHIFT + M)
--------------------------------------------------------------------------------

local STATE = "internal-display" -- "on" / "off", kept in ~/.local/state/hypr/

local function connected(m)
    for _, mon in ipairs(hl.get_monitors()) do
        -- get_monitors() only returns enabled monitors, which is what we want:
        -- a disabled panel must read as "off".
        if mon.description and mon.description:find(m.desc, 1, true) then
            return mon
        end
    end
    return nil
end

local function apply_internal(enabled)
    if enabled then
        -- `disabled = false` has to be explicit: re-applying a monitor rule
        -- without it leaves a previously disabled output disabled (verified on
        -- a nested instance).
        local spec = rule(internal)
        spec.disabled = false
        hl.monitor(spec)
    else
        hl.monitor({ output = "desc:" .. internal.desc, disabled = true })
    end
end

-- What the laptop panel *should* be right now.
local function internal_should_be_on()
    -- Safety first: without the ultrawide the laptop panel is the only output,
    -- so a remembered "off" must never leave the machine with no display.
    if not connected(external) then return true end

    if AUTO_DISABLE_INTERNAL_WHEN_DOCKED then return false end

    return L.read_state(STATE) ~= "off"
end

local enforcing = false

-- Re-applies the remembered choice. Runs on every event that can silently
-- resurrect the panel: session start, config reload and monitor hotplug.
local function enforce()
    if enforcing then return end -- applying a monitor rule re-fires monitor events
    enforcing = true
    apply_internal(internal_should_be_on())
    enforcing = false
end

hl.on("hyprland.start", enforce)
hl.on("config.reloaded", enforce)
hl.on("monitor.added", enforce)
hl.on("monitor.removed", enforce)

--------------------------------------------------------------------------------
-- SUPER + SHIFT + M
--------------------------------------------------------------------------------

-- Exposed globally so it can also be driven from outside Hyprland with
-- `hyprctl eval` -- see bin/toggle-internal-display.
function hypr_set_internal_display(enabled)
    if not enabled and not connected(external) then
        hl.notification.create({
            text    = "Not disabling the laptop display: it is the only screen",
            timeout = 3000,
        })
        return true
    end

    L.write_state(STATE, enabled and "on" or "off")
    enforce()

    hl.notification.create({
        text    = enabled and "Laptop display enabled" or "Laptop display disabled",
        timeout = 2000,
    })
    return enabled
end

function hypr_toggle_internal_display()
    return hypr_set_internal_display(connected(internal) == nil)
end

hl.bind("SUPER + SHIFT + M", function() hypr_toggle_internal_display() end,
    { desc = "Toggle laptop display" })
