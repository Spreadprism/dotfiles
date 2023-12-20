local M = {}

local ufo_bind = "<leader>f"

M.n = {
	[ufo_bind .. "O"] = {
		function()
			require("ufo").openAllFolds()
		end,
		"Open all folds",
	},
	[ufo_bind .. "o"] = {
		"zo",
		"Open fold",
	},
	[ufo_bind .. "C"] = {
		function()
			require("ufo").closeAllFolds()
		end,
		"Close all folds",
	},
	[ufo_bind .. "c"] = {
		"zc",
		"Close fold",
	},
}

return M
