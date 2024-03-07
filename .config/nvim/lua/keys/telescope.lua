local M = {}

local BASE_KEY = "<leader>s"
local keymap = function(key)
	return BASE_KEY .. key
end

local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
M.n = {
	["<leader>S"] = {
		builtin.pickers,
		"Search files",
	},
	[keymap("f")] = {
		builtin.find_files,
		"Search files",
	},
	[keymap("g")] = {
		builtin.current_buffer_fuzzy_find,
		"Fuzzy find buffer",
	},
	[keymap("e")] = {
		builtin.diagnostics,
		"Search diagnostics",
	},
	[keymap("G")] = {
		function()
			local ignore_patterns = {
				"!.git/*",
				"!**/node_modules/*",
				"!/target/*",
				"!.next/*",
				"!**/__pycache__/*",
			}
			builtin.live_grep({ glob_pattern = ignore_patterns })
		end,
		"Grep workspace",
	},
	[keymap("w")] = {
		extensions.workspaces.workspaces,
		"Search workspaces",
	},
	[keymap("d")] = {
		builtin.lsp_definitions,
		"Search definition",
	},
	[keymap("r")] = {
		builtin.lsp_references,
		"Search reference",
	},
	[keymap("b")] = {
		extensions.dap.list_breakpoints,
		"Search reference",
	},
	[keymap("m")] = {
		"<CMD>Telescope harpoon marks theme=dropdown<CR>",
		"Search harpoon marks",
	},
}

return M
