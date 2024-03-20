local M = {}

local BASE_KEY = "<leader>g"
local keymap = function(key)
	return BASE_KEY .. key
end

M.n = {
	[keymap("b")] = { "<CMD>GitMessenger<CR>", "Toggle commit message" },
	[keymap("o")] = { "<CMD>Neogit<CR>", "Open Neogit" },
}

return M
