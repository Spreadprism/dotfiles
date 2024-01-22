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
		config = function()
			require("mini.files").setup({
				content = {
					prefix = function(fs_entry)
						local file_utility = require("utility.file_utility")
						if fs_entry.fs_type == "directory" then
							local items = file_utility.get_childs(fs_entry.path, nil, { levels = 1 })
							if #items == 0 then
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
					up = "",
					down = "",
					line_left = "",
					line_right = "",
					line_down = "",
					line_up = "",
				},
			})
		end,
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	version = "*",
	-- 	lazy = false,
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		-- local function my_on_attach(bufnr)
	-- 		-- 	local api = require("nvim-tree.api")
	-- 		--
	-- 		-- 	local function opts(desc)
	-- 		-- 		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	-- 		-- 	end
	-- 		--
	-- 		-- 	-- default mappings
	-- 		-- 	api.config.mappings.default_on_attach(bufnr)
	-- 		--
	-- 		-- 	-- custom mappings
	-- 		-- 	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	-- 		-- 	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	-- 		-- end
	-- 		require("nvim-tree").setup({
	-- 			sync_root_with_cwd = true,
	-- 			reload_on_bufenter = true,
	--        respect_buf_cwd = true,
	-- 		})
	-- 	end,
	-- },
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
					"help",
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
				["<leader>sc"] = { name = "+current buffer" },
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
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local builtin = require("telescope.builtin")
			-- INFO: general
			vim.keymap.set("n", "<leader>sC", builtin.commands, { desc = "Search commands" })
			-- INFO: history
			vim.keymap.set("n", "<leader>shc", builtin.command_history, { desc = "Search commands history" })
			-- INFO: git
			-- vim.keymap.set("n", "<leader>sgB", builtin.git_branches, { desc = "Search branches" })
			-- vim.keymap.set("n", "<leader>sgc", builtin.git_commits, { desc = "Search commits" })
			-- vim.keymap.set("n", "<leader>sgbc", builtin.git_bcommits, { desc = "Search commits" })
			-- INFO: lsp
			vim.keymap.set("n", "<leader>se", builtin.diagnostics, { desc = "Search errors" })
			vim.keymap.set("n", "<leader>sd", builtin.lsp_definitions, { desc = "Search definition" })
			vim.keymap.set("n", "<leader>si", builtin.lsp_implementations, { desc = "Search definition" })
			vim.keymap.set("n", "<leader>sr", builtin.lsp_references, { desc = "Search reference" })
			-- INFO: files
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
			vim.keymap.set(
				"n",
				"<leader>sw",
				require("telescope").extensions.workspaces.workspaces,
				{ desc = "Search workspaces" }
			)

			vim.keymap.set("n", "<leader>sG", builtin.live_grep, { desc = "Grep workspace" })
			-- INFO: current file
			vim.keymap.set("n", "<leader>sg", builtin.current_buffer_fuzzy_find, { desc = "Grep current file" })

			vim.keymap.set("n", "<leader>sce", function()
				require("telescope.builtin").diagnostics({ bufnr = 0 })
			end, { desc = "Search errors" })

			-- INFO: Search configs
			local telescopeConfig = require("telescope.config")

			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			local trouble = require("trouble.providers.telescope")
			local fb_actions = require("telescope").extensions.file_browser.actions
			require("telescope").setup({
				file_ignore_patterns = { "%.env" },
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					mappings = {
						i = {
							["<Tab>"] = require("telescope.actions").move_selection_next,
							["<S-Tab>"] = require("telescope.actions").move_selection_previous,
							["<C-q>"] = require("telescope.actions").close,
							["<c-t>"] = trouble.open_with_trouble,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!**/.git/*",
							"--glob",
							"!**/node_modules/*",
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					file_browser = {
						theme = "ivy",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
						mappings = {
							["i"] = {
								["<A-a>"] = fb_actions.create,
							},
							["n"] = {
								-- your custom normal mode mappings
							},
						},
					},
				},
			})
		end,
	},
	{
		-- INFO: fzf syntax
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
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<M-a>",
						dismiss = "<M-d>",
						next = "<M-l>",
						prev = "<M-h>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
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
	{
		"cvigilv/esqueleto.nvim",
		config = function()
			local templates_dir = vim.fn.stdpath("config") .. "/lua" .. "/templates"
			-- get all directories name in templates_dir in table
			local directories_name = vim.fn.readdir(templates_dir)
			require("esqueleto").setup({
				directories = { templates_dir },
				patterns = directories_name,
			})
		end,
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
}
