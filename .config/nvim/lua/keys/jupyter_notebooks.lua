local M = {}
local env = require("utility.env")

local BASE_KEY = "<leader>j"
local jupyter_template_path = vim.fs.joinpath(env.get("nvimHome"), "lua", "templates", "base.ipynb")

local keymap = function(key)
	return BASE_KEY .. key
end

M.n = {
	[keymap("nn")] = {
		function()
			local new_file_name = vim.fn.input("New notebook name: ")
			vim.fn.system({
				"cp",
				jupyter_template_path,
				"./" .. new_file_name .. ".ipynb",
			})
			print("Created new notebook: " .. new_file_name .. ".ipynb")
		end,
		"new notebook",
	},
	[keymap("ks")] = {
		function()
			vim.cmd("MoltenDeinit")
			vim.cmd("MoltenInit")
		end,
		"Select kernel",
	},
	[keymap("x")] = {
		function()
			require("quarto.runner").run_cell()
		end,
		"execute cell",
	},
}

return M
