plugin("stevearc/dressing.nvim"):event("VeryLazy")
plugin("MunifTanjim/nui.nvim"):event("VeryLazy")
plugin("karb94/neoscroll.nvim"):event("VeryLazy"):opts({ stop_eof = false })
plugin("folke/noice.nvim"):event("VeryLazy")
plugin("nvim-lualine/lualine.nvim"):event("VeryLazy")
plugin("utilyre/barbecue.nvim"):event("VeryLazy"):dependencies({
	"SmiteshP/nvim-navic",
	"nvim-tree/nvim-web-devicons",
})
plugin("rcarriga/nvim-notify")
	:event("VeryLazy")
	:opts({ render = "compact", background_colour = "#000000", stage = "slide" })
