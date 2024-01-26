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
	[keymap("G")] = {
		builtin.live_grep,
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
	[keymap("m")] = {
		"<CMD>Telescope harpoon marks theme=dropdown<CR>",
		"Search harpoon marks",
	},
}

return M
