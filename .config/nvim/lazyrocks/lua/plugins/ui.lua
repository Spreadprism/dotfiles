plugin("stevearc/dressing.nvim"):event("VeryLazy")
plugin("MunifTanjim/nui.nvim"):event("VeryLazy")
plugin("karb94/neoscroll.nvim"):event("VeryLazy"):opts({ stop_eof = false, hide_cursor = false }) -- BUG: Cursor is perm hidden
plugin("nvim-lualine/lualine.nvim"):event("VeryLazy")
plugin("utilyre/barbecue.nvim"):event("BufRead"):dependencies({
	"SmiteshP/nvim-navic",
	"nvim-tree/nvim-web-devicons",
})
plugin("rcarriga/nvim-notify")
	:event("VeryLazy")
	:opts({ render = "compact", background_colour = "#000000", stage = "slide" })
plugin("folke/which-key.nvim"):event("VeryLazy")
plugin("folke/noice.nvim"):event("VeryLazy"):opts({
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
})