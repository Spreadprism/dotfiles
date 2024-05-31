local keybind = require("utility.keybind_manager").Keybind.new
require("hop").setup({})

local main_hop_f = function()
	local current_oil_dir = require("oil").get_current_dir()
	if current_oil_dir == nil then
		vim.cmd("HopWord")
	else
		vim.cmd("HopLine")
	end
end

keybind("n", "F", main_hop_f, "Jump to word"):register()
keybind("n", "f", "<cmd>HopChar1<CR>", "Jump to word"):register()
