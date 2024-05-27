require("noice").setup({
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