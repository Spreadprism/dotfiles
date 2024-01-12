local setup = function()
	require("dashboard").setup({
		theme = "doom",
		config = {
			header = require("configs.dashboard.header"), --your header
			center = require("configs.dashboard.center"), --your center
			footer = require("configs.dashboard.footer"), --your footer
		},
	})
end
return function()
	setup()
	vim.api.nvim_create_autocmd("DirChanged", {
		pattern = "global",
		callback = function()
			setup()
		end,
	})
end
