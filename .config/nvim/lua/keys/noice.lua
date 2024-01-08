local M = {}

local base_bind = "<leader>N"
M.n = {
	[base_bind .. "l"] = {
		function()
			require("noice").cmd("last")
		end,
		"Show last message",
	},
	[base_bind .. "d"] = {
		function()
			require("noice").cmd("dismiss")
		end,
		"Dismiss notification",
	},
	[base_bind .. "e"] = {
		function()
			require("noice").cmd("errors")
		end,
		"Open errors",
	},
}

return M
