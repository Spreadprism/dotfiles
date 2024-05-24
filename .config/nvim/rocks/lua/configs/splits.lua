require("smart-splits").setup({
	resize_mode = {
		silent = true,
		quit_key = ";",
	},
})
local keybind = require("utility.keybind_manager").Keybind.new

keybind("n", "<M-v>", "<cmd>vsplit<CR>", "Vertical split"):register()
keybind("n", "<M-V>", "<cmd>split<CR>", "Horizontal split"):register()
keybind("n", "<M-r>", function()
	require("smart-splits").start_resize_mode()
end, "Start resize mode"):register()
