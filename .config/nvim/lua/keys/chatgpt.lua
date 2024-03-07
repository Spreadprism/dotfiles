local M = {}

local BASE_KEY = "<leader>C"
local keymap = function(key)
	return BASE_KEY .. key
end

M.n = {
	-- ["<leader>oC"] = {
	-- 	"<CMD>ChatGPT<CR>",
	-- 	"Open ChatGPT",
	-- },
}

return M
