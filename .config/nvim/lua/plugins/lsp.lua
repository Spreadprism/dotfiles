return {
	{
		event = "VeryLazy",
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
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
	{ "folke/neodev.nvim", event = "VeryLazy", opts = {} },
	{
		"folke/neoconf.nvim",
		lazy = false,
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
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
		config = function(_, opts)
			local ls = require("luasnip")
			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
