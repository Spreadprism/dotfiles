-- Configs
vim.g.lazyrock = {
	lazy_init = false,
	lua_directory_name = vim.fn.stdpath("config") .. "/lua",
	plugins_directory_name = "plugins",
	configs_directory_name = "configs",
	keybinds_directory_name = "keybinds",
	snippets_directory_name = "snippets",
	templates_directory_name = "templates",
}

-- global funcs
print = vim.print
keybind = require("utils.keybinds").Keybind
keybind_group = require("utils.keybinds").KeybindGroup
plugin = require("utils.plugins_specs").Plugin
