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

M.register = function()
	local configs = require("lspconfig.configs")
	local env = require("utility.env")

	if env.get("DELANCE_EXISTS") == "true" and not configs.delance then
		configs.pylance = {
			default_config = {
				cmd = { "delance-langserver", "--stdio" },
				filetypes = { "python" },
				root_dir = function(fname)
					return util.root_pattern(unpack(root_files))(fname)
				end,
				single_file_support = true,
				settings = {
					python = {
						analysis = {
							include = {
								env.get("HOME") .. "/.config/nvim/python/",
								env.get("workspaceFolder"),
								env.get("workspaceFolder") .. "/src",
								env.get("workspaceFolder") .. "/src/" .. env.get("workspaceFolderBaseName"),
							},
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			},
		}
	end
end

return M