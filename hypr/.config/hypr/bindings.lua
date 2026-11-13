-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-------------------------------------------------------------------------------
-- Application Bindings
-------------------------------------------------------------------------------
-- Web Apps
hl.unbind("SUPER + SHIFT + M")
o.bind("SUPER + SHIFT + M", "Music", "omarchy-launch-webapp \"https://music.youtube.com\"")
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "WhatsApp", { webapp = "https://web.whatsapp.com/", focus = true })
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Gemini", "omarchy-launch-webapp \"https://gemini.google.com\"")
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Calendar", "omarchy-launch-webapp \"https://app.hey.com/calendar/weeks/\"")
hl.unbind("SUPER + SHIFT + E")
o.bind("SUPER + SHIFT + E", "Email", "omarchy-launch-webapp \"https://mail.google.com\"")

-------------------------------------------------------------------------------
-- Window Navigation & Overrides
-------------------------------------------------------------------------------

hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + UP")
hl.unbind("SUPER + DOWN")
hl.unbind("SUPER + L")
hl.unbind("SUPER + K")
hl.unbind("SUPER + J")

-- Navigation bindings
o.bind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))

-- Layout and Utility
o.bind("SUPER + SHIFT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + CTRL + K", "Show key bindings", "omarchy-menu-keybindings")
o.bind("SUPER + I", "Toggle window split", "hyprctl dispatch layoutmsg togglesplit")

o.bind("SUPER + I", "Toggle window split", hl.dsp.layout("togglesplit"))



-- Plugins
--
