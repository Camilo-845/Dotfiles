local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Configuración explícita con escala 1
hl.monitor({ output = "eDP-1", mode = "1366x768@60", position = "1920x900", scale = omarchy_monitor_scale })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = omarchy_monitor_scale })

-- l2
-- hl.monitor({ output = "eDP-1", mode = "1366x768@60", position = "0x0", scale = omarchy_monitor_scale })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1366x-700", scale = omarchy_monitor_scale })

for w = 1, 5 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "HDMI-A-1",
	})
end

-- Map Workspaces 6 to 10 to eDP-1
for w = 6, 10 do
	hl.workspace_rule({
		workspace = tostring(w),
		monitor = "eDP-1",
	})
end
