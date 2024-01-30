local M = {}

M.n = {
	["f"] = { "<cmd>HopChar1<CR>", "Jump to char" },
	["F"] = { "<cmd>HopWord<CR>", "Jump to word" },
}

M.v = {
	["f"] = { "<cmd>HopChar1CurrentLine<CR>", "Jump to char current line" },
	["F"] = { "<cmd>HopLine<CR>", "Jump to line" },
}

return M
