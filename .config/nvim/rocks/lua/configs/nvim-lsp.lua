local lspconfig = require("lspconfig")
local keybind = require("utility.keybind_manager").Keybind.new
local keybind_group = require("utility.keybind_manager").KeybindGroup.new

local lspgroup = keybind_group("<leader>l", "language server")

require("neoconf").setup()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_namespace("UserLspConfig"),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }
		keybind("n", "K", vim.lsp.buf.hover, "Show hover information", opts):register()
		keybind("n", "<f2>", vim.lsp.buf.rename, "Show hover information", opts):register()

		lspgroup:register({
			keybind({ "n", "v" }, "a", vim.lsp.buf.code_action, "Show code actions", opts),
		})
	end,
})

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local default_on_attach = function(client, bufnr) end

if vim.fn.executable("delance-langserver") == 1 then
	local configs = require("lspconfig.configs")
	local root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	}
	configs.pylance = {
		default_config = {
			cmd = { "delance-langserver", "--stdio" },
			filetypes = { "python" },
			root_dir = function(fname)
				return lspconfig.util.root_pattern(table.unpack(root_files))(fname)
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

local initialized_servers = {}

local configure_lsp = function(lsp_name)
	if not initialized_servers[lsp_name] then
		local configure = function()
			lspconfig[lsp_name].setup(require("configs.lsp." .. lsp_name)(default_on_attach, default_capabilities))
		end
		if pcall(configure) then
			initialized_servers[lsp_name] = true
		else
			error("Failed to configure LSP: " .. lsp_name)
		end
	end
end

local names = require("utility.lsp").get_all_lsp_servers()
for _, file in ipairs(names) do
	configure_lsp(file)
end
