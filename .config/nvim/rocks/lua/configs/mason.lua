require("mason").setup()
require("mason-lspconfig").setup()
require("mason-nvim-dap").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		-- INFO: LSP
		"bash-language-server",
		"rust-analyzer",
		"lua-language-server",
		"pyright",
		"typescript-language-server",
		"ruby-lsp",
		-- INFO: DAP
		"codelldb",
		"debugpy",
		"delve",
		-- INFO: Tools
		"ruff",
	},
})
