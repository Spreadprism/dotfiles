return {
	{
		"thehamsta/nvim_rocks",
		event = "VeryLazy",
		build = "pipx install hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
		config = function()
			local nvim_rocks = require("nvim_rocks")
			nvim_rocks.ensure_installed("fzy")
			nvim_rocks.ensure_installed("luafilesystem")
			nvim_rocks.ensure_installed("magick")
			-- INFO: luarocks
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"NeogitOrg/neogit",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			disable_hint = true,
			integrations = {
				telescope = true,
				diffview = true,
			},
			graph_style = "unicode",
			mappings = {
				finder = {
					["<tab>"] = "Next",
					["<s-tab>"] = "Previous",
				},
			},
		},
	},
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"rhysd/git-messenger.vim",
		event = "VeryLazy",
	},
	{
		"crnvl96/lazydocker.nvim",
		event = "VeryLazy",
		opts = {}, -- automatically calls `require("lazydocker").setup()`
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				current_line_blame = false,
				current_line_blame_opts = {
					delay = 200,
					ignore_whitespace = true,
				},
				current_line_blame_formatter = "<author> @ <author_time:%Y-%m-%d> : <summary> ",
			})
		end,
	},
	{
		"rhysd/git-messenger.vim",
		cmd = "GitMessenger",
	},
	{
		"MeanderingProgrammer/py-requirements.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("py-requirements").setup({
				-- Enabled by default if you do not use `nvim-cmp` set to false
				enable_cmp = true,
				-- Specify what file patterns to apply the plugin to
				-- For info on patterns, see :h pattern
				file_patterns = { "requirements.txt" },
				-- For available options, see :h vim.lsp.util.open_floating_preview
				float_opts = { border = "rounded" },
			})
		end,
	},
	{
		"saecki/crates.nvim",
		tag = "v0.4.0",
		ft = { "rust", "toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				popup = {
					autofocus = true,
				},
				-- src = {
				-- 	cmp = {
				-- 		enabled = true,
				-- 	},
				-- },
			})
		end,
	},
	{
		"weirongxu/plantuml-previewer.vim",
		event = "VeryLazy",
		dependencies = {
			"tyru/open-browser.vim",
			"aklt/plantuml-syntax",
		},
	},
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local overseer = require("overseer")
			overseer.setup()
			require("dap.ext.vscode").json_decode = require("overseer.json").decode
		end,
	},
	{
		"smoka7/hop.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {},
	},
	{
		"rmagatti/auto-session",
		opts = {
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			auto_restore_enabled = false,
		},
	},
	{
		"ziontee113/icon-picker.nvim",
		event = "VeryLazy",
		config = function()
			require("icon-picker").setup({ disable_legacy_commands = true })
		end,
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- configuration goes here
			lang = "rust",
		},
	},
}