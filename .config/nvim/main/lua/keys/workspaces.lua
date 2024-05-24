local M = {}
local base_path = "<leader>w"

M.n = {
	[base_path .. "l"] = {
		"<cmd>WorkspacesList<cr>",
		"List workspaces",
	},
	[base_path .. "a"] = {
		"<cmd>WorkspacesAdd<cr>",
		"Add workspace",
	},
	[base_path .. "r"] = {
		"<cmd>WorkspacesRemove<cr>",
		"Remove workspace",
	},
}

return M
