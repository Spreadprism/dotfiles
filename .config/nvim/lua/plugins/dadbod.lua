return {
	{
		"tpope/vim-dadbod",
		event = "VeryLazy",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		event = "VeryLazy",
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.cmd([[let g:db_ui_disable_mappings = 1]])
			vim.cmd([[autocmd FileType dbui nmap <buffer> o <Plug>(DBUI_SelectLine)]])
			vim.cmd([[autocmd FileType dbui nmap <buffer> <CR> <Plug>(DBUI_SelectLine)]])
			vim.cmd([[autocmd FileType dbui nmap <buffer> <leader>Ds <Plug>(DBUI_SaveQuery)]])
			vim.cmd([[autocmd FileType dbui nmap <buffer> h <Plug>(DBUI_ToggleDetails)]])
			vim.cmd([[autocmd FileType dbui nmap <buffer> R <Plug>(DBUI_Redraw)]])
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = "hrsh7th/nvim-cmp",
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = {
					"sql",
					"mysql",
					"plsql",
				},
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
				end,
			})
		end,
	},
}
