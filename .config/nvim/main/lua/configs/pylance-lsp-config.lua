local M = {}

local util = require("lspconfig.util")

local root_files = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
	".git",
}

local function set_python_path(path)
	local clients = vim.lsp.get_active_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "pylance",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		client.notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

M.build_configs = function()
	local env = require("utility.env")

	return {
		default_config = {
			cmd = { "delance-langserver", "--stdio" },
			filetypes = { "python" },
			root_dir = function(fname)
				return util.root_pattern(table.unpack(root_files))(fname)
			end,
			single_file_support = true,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
					},
				},
			},
		},
	}
end

M.register = function()
	local configs = require("lspconfig.configs")
	local env = require("utility.env")

	if env.get("DELANCE_EXISTS") == "true" and not configs.pylance then
		configs.pylance = M.build_configs()
	end
end

return M
