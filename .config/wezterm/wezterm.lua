local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

-- # Appearance
config.color_scheme = "Tokyo Night Storm"
config.window_background_opacity = 0.7
config.enable_tab_bar = false

-- Fonts
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 13

-- # Keybinds
config.keys = {
	-- paste from the clipboard
	{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },
}

return config
