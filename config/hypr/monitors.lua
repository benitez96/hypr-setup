-- Monitors. See https://wiki.hypr.land/Configuring/Basics/Monitors/
local L = ...

-- The ultrawide is matched by *description*: it enumerates as DP-2 or DP-3
-- depending on hotplug/dock order, which is why a `monitor = DP-2, ...` rule
-- silently stopped applying. Descriptions come from `hyprctl monitors all`.
--
-- The built-in panel is matched by connector name instead: it never changes
-- name, and enabling/disabling an output only works with the connector --
-- `disabled = true` against a `desc:` selector is accepted and does nothing.
local internal = {
    output   = "eDP-1",
    desc     = "AU Optronics 0x48B0", -- only used to recognise it in queries
    mode     = "2240x1400@60",
    position = "auto",
    scale    = "auto",
}

local external = {
    output   = "desc:Samsung Electric Company S34CG50",
    desc     = "Samsung Electric Company S34CG50", -- ultrawide 34"
    mode     = "3440x1440@60",
    position = "auto",
    scale    = 1,
}

-- Turn the laptop panel off whenever the ultrawide is connected, even with the
-- lid open. Off by default: the lid already drives it (see below).
local AUTO_DISABLE_INTERNAL_WHEN_DOCKED = false

local STATE = "internal-display" -- "on" / "off", kept in ~/.local/state/hypr/

--------------------------------------------------------------------------------
-- Monitor rules
--------------------------------------------------------------------------------

local function rule(m)
    return { output = m.output, mode = m.mode, position = m.position, scale = m.scale }
end

-- Fallback for anything not listed here (projectors, a new external, ...)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.monitor(rule(external))

-- The laptop panel deliberately gets *no* static rule: enforce() below is its
-- only owner. A runtime hl.monitor() for a selector that already has a rule is
-- merged into it, and a static rule never says `disabled`, so it would keep
-- quietly switching the panel back on. enforce() runs at parse time too, so the
-- panel still gets its mode from the start.

hl.env("GDK_SCALE", "1")

--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------

-- get_monitors() only returns enabled monitors, so a disabled panel reads as
-- "not connected", which is exactly what we want here.
local function connected(m)
    for _, mon in ipairs(hl.get_monitors()) do
        if mon.description and mon.description:find(m.desc, 1, true) then
            return mon
        end
    end
    return nil
end

local function lid_closed()
    local f = io.open("/proc/acpi/button/lid/LID/state", "r")
    if not f then return false end

    local line = f:read("l") or ""
    f:close()

    return line:find("closed", 1, true) ~= nil
end

-- What the laptop panel *should* be right now.
local function internal_should_be_on()
    -- Lid first, and *without* consulting get_monitors(): enforce() runs on
    -- monitor events and reloads, moments when the monitor list is transiently
    -- incomplete. Checking the external screen first meant a misread of "no
    -- ultrawide" -> "panel is the only screen" -> re-enable, which is what kept
    -- resurrecting the disabled panel behind a closed lid. A closed lid never
    -- wants its panel; if everything ends up disabled Hyprland creates a
    -- FALLBACK output by itself (verified on a nested instance), so this
    -- cannot leave the machine without a display.
    if lid_closed() then return false end

    -- Without the ultrawide the laptop panel is the only real output.
    if not connected(external) then return true end

    if AUTO_DISABLE_INTERNAL_WHEN_DOCKED then return false end

    return L.read_state(STATE) ~= "off"
end

--------------------------------------------------------------------------------
-- Applying it
--------------------------------------------------------------------------------

-- Enabling/disabling an output leaves part of the screen painted with the old
-- frame until something forces a full redraw (taking a screenshot used to be
-- the accidental fix). The geometry itself is already correct, so one renderer
-- reload after the new layout settles is enough.
--
-- This hangs off monitor.layout_changed rather than a timer on purpose:
-- hl.timer segfaults when the config is parsed, and enforce() does run at parse
-- time.
local pending_redraw = false

hl.on("monitor.layout_changed", function()
    if not pending_redraw then return end
    pending_redraw = false -- also stops the reload from re-triggering us

    hl.dispatch(hl.dsp.force_renderer_reload())
end)

local function apply_internal(enabled)
    pending_redraw = true

    if enabled then
        local spec = rule(internal)
        spec.disabled = false -- has to be explicit, or a disabled output stays off
        hl.monitor(spec)
    else
        -- Only the selector and `disabled`: sending mode/position/scale here
        -- makes Hyprland treat it as a plain (enabled) monitor rule.
        --
        -- If the panel is still enabled while the stored rule already says
        -- disabled (a reload reset can leave it that way), re-sending the same
        -- rule is a "no change" no-op. Flip it once so the disable is a real
        -- transition and actually gets applied.
        if connected(internal) then
            hl.monitor({ output = internal.output, disabled = false })
        end
        hl.monitor({ output = internal.output, disabled = true })
    end
end

local enforcing = false

-- Re-applies the wanted state. Runs on everything that can silently resurrect
-- the panel: session start, config reload, monitor hotplug and the lid switch.
local function enforce()
    if enforcing then return end -- applying a monitor rule re-fires monitor events
    enforcing = true
    apply_internal(internal_should_be_on())
    enforcing = false
end

-- A single enforce() at event time is not enough: during reloads and monitor
-- hotplug churn Hyprland's own rule application races these handlers, and the
-- loser's work is silently overwritten -- the panel came back on roughly every
-- other reload. Each trigger therefore also schedules one deferred pass for
-- after the dust settles. hl.timer segfaults at *parse* time, but these
-- handlers all run at runtime, where it works (verified on a nested instance).
local function enforce_soon()
    enforce()
    hl.timer(enforce, { type = "oneshot", timeout = 400 })
end

hl.on("hyprland.start", enforce_soon)
hl.on("config.reloaded", enforce_soon)
hl.on("monitor.added", enforce_soon)
hl.on("monitor.removed", enforce_soon)

-- Deliberately NO parse-time enforce(): a disable-only rule declared at parse
-- is stored but never actively applied, and its existence then makes the
-- runtime hl.monitor() calls above a "no change" no-op (see apply_internal's
-- flip) -- the panel got stuck enabled behind a closed lid.

-- Follow the lid: closing it turns the panel off (unless it is the only
-- screen), opening it brings the panel back. Opening also clears a manual
-- SUPER + SHIFT + M "off", so the lid always wins and the behaviour stays
-- predictable.
hl.bind("switch:on:Lid Switch", function() enforce() end, { desc = "Lid closed" })

hl.bind("switch:off:Lid Switch", function()
    L.write_state(STATE, "on")
    enforce()
end, { desc = "Lid opened" })

--------------------------------------------------------------------------------
-- SUPER + SHIFT + M
--------------------------------------------------------------------------------

local function notify(text, timeout)
    hl.notification.create({ text = text, timeout = timeout or 2000 })
end

-- Exposed globally so it can also be driven from outside Hyprland with
-- `hyprctl eval` -- see bin/toggle-internal-display.
function hypr_set_internal_display(enabled)
    if not enabled and not connected(external) then
        notify("Not disabling the laptop display: it is the only screen", 3000)
        return true
    end

    -- Only the *enable* direction is blocked by a closed lid. A disable request
    -- must still go through enforce(): the panel can be stuck enabled with the
    -- lid closed (e.g. the rule that should have disabled it never applied).
    if enabled and lid_closed() then
        notify("The laptop lid is closed, leaving its display off", 3000)
        return false
    end

    L.write_state(STATE, enabled and "on" or "off")
    enforce()

    notify(enabled and "Laptop display enabled" or "Laptop display disabled")
    return enabled
end

function hypr_toggle_internal_display()
    return hypr_set_internal_display(connected(internal) == nil)
end

hl.bind("SUPER + SHIFT + M", function() hypr_toggle_internal_display() end,
    { desc = "Toggle laptop display" })
