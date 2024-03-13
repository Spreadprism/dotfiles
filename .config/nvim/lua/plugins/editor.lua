return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("configs.neo-tree"),
	},
	{
		"echasnovski/mini.files",
		event = "VeryLazy",
		config = function()
			require("mini.files").setup({
				content = {
					prefix = function(fs_entry)
						local file_utility = require("utility.file_utility")
						if fs_entry.fs_type == "directory" then
							if file_utility.is_empty_dir(fs_entry.path) then
								return " ", "MiniFilesDirectory"
							else
								return " ", "MiniFilesDirectory"
							end
						else
							return require("mini.files").default_prefix(fs_entry)
						end
					end,
				},
				mappings = {
					go_in = "L",
					go_in_plus = "l",
					go_out = "H",
					go_out_plus = "h",
				},
			})
		end,
	},
	{
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup({
				mappings = {
					up = "<M-k>",
					down = "<M-j>",
					right = "<M-l>",
					left = "<M-h>",

					line_left = "",
					line_right = "",
					line_down = "<M-j>",
					line_up = "<M-k>",
				},
			})
		end,
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "VeryLazy",
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"",
					"help",
					"leetcode.nvim",
					"norg",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			window = {
				border = "rounded",
			},
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>a"] = { name = "+actions" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>d"] = { name = "+debugging" },
				["<leader>l"] = { name = "+language server" },
				["<leader>y"] = { name = "+yank current file info" },
				["<leader>h"] = { name = "+harpoon" },
				["<leader>o"] = { name = "+open" },
				["<leader>t"] = { name = "+test" },
				["<leader>g"] = { name = "+git" },
				["<leader>c"] = { name = "+cargo" },
				["<leader>n"] = { name = "+neorg" },
				["<leader>N"] = { name = "+noice" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>j"] = { name = "+jupynium" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				-- ["<leader>sc"] = { name = "+current buffer" },
				["<leader>sh"] = { name = "+history" },
				-- ["<leader>sg"] = { name = "+git" },
				-- ["<leader>sgb"] = { name = "+current buffer" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+workspaces" },
				["<leader>x"] = { name = "+export" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = require("configs.telescope"),
	},
	{
		-- INFO: fzf syntax
		--
		-- sbtrkt : fuzzy-match
		-- 'wild : exact-match (quoted)
		-- ^music : prefix-exact-match
		-- .mp3 : suffix-exact-match
		-- !fire : inverse-exact-match
		-- !^ : inverse prefix-eact-match
		-- !. : inverse-suffix-exact-match
		"nvim-telescope/telescope-fzf-native.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		build = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	{
		"ellisonleao/dotenv.nvim",
		event = "VeryLazy",
		config = function()
			require("dotenv").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
				---@diagnostic disable-next-line: different-requires
				surrounds = require("configs.nvim-surround"),
			})
		end,
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			auto_preview = false,
			auto_fold = true,
			use_diagnostic_signs = true,
		},
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup({})

			vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope keywords=TODO<CR>", { desc = "Search TODO" })
			vim.keymap.set("n", "<leader>s#", "<cmd>TodoTelescope<CR>", { desc = "Find tags" })
		end,
		-- PERF: test perf?
		-- HACK: bruh
		-- TODO: wew
		-- NOTE:  sdkfj dkfjskdfj
		-- FIX: fixed
		-- WARNING: test done
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		event = "VeryLazy",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			require("harpoon").setup({})
			require("telescope").load_extension("harpoon")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			is_insert_mode = true,
		},
	},
	{
		"mg979/vim-visual-multi",
		event = "VeryLazy",
	},
	-- {
	-- 	"cvigilv/esqueleto.nvim",
	-- 	config = function()
	-- 		local templates_dir = vim.fn.stdpath("config") .. "/lua" .. "/templates"
	-- 		-- get all directories name in templates_dir in table
	-- 		local directories_name = vim.fn.readdir(templates_dir)
	-- 		require("esqueleto").setup({
	-- 			directories = { templates_dir },
	-- 			patterns = directories_name,
	-- 		})
	-- 	end,
	-- },
	{
		"Spreadprism/new-file-template.nvim",
		lazy = false,
		priority = 100,
		opts = {
			disable_insert = false, -- Enter in insert mode after inserting the template?,
			disable_autocmd = false, -- Disable the autocmd that creates the template.  You can use manually by calling :InsertTemplateFile,
			disable_autosave = false,
			disable_filetype = {},
			disable_specific = {},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = false,
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = require("configs.ufo-config"),
	},
	{
		"natecraddock/workspaces.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = function()
			local workspace_hooks = require("utility.workspace_utilities")
			require("workspaces").setup({
				auto_open = false,
				hooks = {
					add = workspace_hooks.on_add,
					remove = workspace_hooks.on_remove,
					rename = workspace_hooks.on_rename,
					open_pre = workspace_hooks.on_open_pre,
					open = workspace_hooks.on_open,
				},
			})
			require("telescope").load_extension("workspaces")
		end,
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
		config = function()
			local env = require("utility.env")
			require("venv-selector").setup({
				dap_enabled = true,
				notify_user_on_activate = false,
				anaconda_base_path = env.get("HOME") .. "/miniconda3",
				anaconda_envs_path = env.get("HOME") .. "/miniconda3/envs",
				-- auto_refresh = false
			})
		end,
		event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ "<leader>lv", "<cmd>VenvSelect<cr>" },
		},
	},
}
