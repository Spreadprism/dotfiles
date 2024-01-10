return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		-- transparent = true,
		dependencies = "xiyaowong/transparent.nvim",
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	-- {
	-- 	"baliestri/aura-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function(plugin)
	-- 		vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
	-- 		vim.cmd([[colorscheme aura-dark]])
	-- 	end,
	-- },
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				extra_groups = {
					-- "NotifyBackground",
					-- "NormalFloat",
					-- "FloatBorder",
					-- "WhichKey",
				},
				exclude_groups = {},
			})
			-- require("transparent").clear_prefix("NeoTree")
			require("transparent").clear_prefix("Notify")
		end,
	},
}
