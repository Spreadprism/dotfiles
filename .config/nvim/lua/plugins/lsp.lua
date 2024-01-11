return {
	{
		event = "VeryLazy",
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"hrsh7th/cmp-nvim-lsp",
			"folke/neoconf.nvim",
			-- "williamboman/mason-lspconfig.nvim",
		},
		-- opts = {
		-- 	diagnostics = {
		-- 		underline = true,
		-- 		virtual_text = {
		-- 			spacing = 2,
		-- 			source = "if_many",
		-- 			prefix = "●",
		-- 		},
		-- 		severity_sort = true,
		-- 	},
		-- 	inlay_hints = {
		-- 		enabled = false,
		-- 	},
		-- },
		config = require("configs.nvim-lsp"),
	},
	{ "folke/neodev.nvim", opts = {} },
	{
		"folke/neoconf.nvim",
		dependencies = "b0o/schemastore.nvim",
		opts = {
			plugins = {
				jsonls = {
					enable = true,
					configured_servers_only = true,
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = require("configs.nvim-cmp"),
	},
}
