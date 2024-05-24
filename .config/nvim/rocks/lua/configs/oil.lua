local keybind = require("utility.keybind_manager").Keybind.new
require("oil").setup({
	use_default_keymaps = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<BS>"] = "actions.parent",
		["<C-q>"] = "actions.close",
		["~"] = "actions.open_cwd",
		["."] = "actions.cd",
	},
	view_options = {
		show_hidden = true,
		natural_order = false,
	},
	win_options = {
		winblend = 10,
		winbar = "%{v:lua.require('utility.oil_current_dir').get_current_dir()}",
	},
})
-- autocmd for when we are in oil
keybind("n", "-", "<CMD>Oil<CR>", "Open parent directory"):register()
keybind("n", "_", function()
	-- Open parent directory of current file
	local current_file = vim.fn.expand("%:p")
	local parent_dir = vim.fn.fnamemodify(current_file, ":h")
	vim.cmd("Oil " .. parent_dir)
end, "Open parent directory"):register()
