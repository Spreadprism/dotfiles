local M = {}

local config_lsp_dir = "configs/lsp/"

M.get_all_lsp_servers = function()
	local lsp_config_dir = vim.fn.stdpath("config") .. "/lua/" .. config_lsp_dir
	local path_util = require("utility.path")

	local lsp_names = {}
	local lspconfig_files = path_util.get_files(lsp_config_dir) or {}
	local pylance_available = vim.fn.executable("delance-langserver") == 1
	for _, file in ipairs(lspconfig_files) do
		local name = file:match("([^/]+)%.lua$")
		if name ~= "pylance" and name ~= "pyright" then
			table.insert(lsp_names, name)
		elseif name == "pyright" and not pylance_available then
			table.insert(lsp_names, name)
		elseif name == "pylance" and pylance_available then
			table.insert(lsp_names, name)
		end
	end

	return lsp_names
end

return M
