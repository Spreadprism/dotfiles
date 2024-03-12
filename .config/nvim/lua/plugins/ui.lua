return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",

		opts = function()
			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = require("configs.lualine.lualine_a"),
					lualine_b = require("configs.lualine.lualine_b"),
					lualine_c = require("configs.lualine.lualine_c"),
					lualine_x = require("configs.lualine.lualine_x"),
					lualine_y = require("configs.lualine.lualine_y"),
					lualine_z = require("configs.lualine.lualine_z"),
				},
			}
		end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = require("configs.dashboard"),
		dependencies = { "nvim-tree/nvim-web-devicons", "chrisbra/Colorizer" },
	},
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
			routes = {
				-- INFO: Remove all saved message
				{
					filter = {
						event = "msg_show",
						find = "written",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						find = "python.addImport",
					},
					opts = { skip = true },
				},
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
				css = { rgb_fn = true },
				scss = { rgb_fn = true },
			})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				strict = false,
				override_by_filename = require("icons.filename"),
				override_by_extension = require("icons.extension"),
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "compact",
				background_colour = "Normal",
				stages = "slide",
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("neoscroll").setup({ stop_eof = false })
		end,
	},
	{
		"kiyoon/jupynium.nvim",
		event = "VeryLazy",
		build = "conda run --no-capture-output -n base pip install .",
		cmd = { "JupyniumStartAndAttachToServer", "JupyniumAttachToServer" },
		config = function()
			require("jupynium").setup({
				-- python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },
				python_host = { "conda", "run", "--no-capture-output", "-n", "base", "python" },
				notebook_dir = vim.fn.getcwd(),
				use_default_keybindings = false,
				-- python = "python3",
				-- jupyter_command = "jupyter",
				jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },
				-- default_notebook_URL = "localhost:8888/",
				auto_start_server = {
					enable = false,
				},
			})
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
	},
	{
		"SmiteshP/nvim-navic",
		event = "VeryLazy",
		config = function()
			require("nvim-navic").setup({
				lsp = {
					preference = {
						"pyright",
					},
				},
			})
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		event = "VeryLazy",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup({
				create_autocmd = false, -- prevent barbecue from updating itself automatically
				attach_navic = false,
			})
			vim.api.nvim_create_autocmd({
				"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",

				-- include this if you have set `show_modified` to `true`
				"BufModifiedSet",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
		end,
	},
}
