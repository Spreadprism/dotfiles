local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.warn_about_missing_glyphs = false

-- Keybinds
config.keys = {
	{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },
}
-- GPU
local gpus = wezterm.gui.enumerate_gpus()
config.enable_wayland = true
config.webgpu_preferred_adapter = gpus[1]
config.enable_kitty_graphics = true

-- UI
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Appearance
config.window_background_opacity = 0.7
config.color_scheme = "Tokyo Night Storm"

-- FONT
config.font_size = 15
config.font = wezterm.font("Jetbrains Mono", { weight = "Medium" })

return config
