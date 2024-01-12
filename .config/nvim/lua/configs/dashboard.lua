return function()
	require("dashboard").setup({
		theme = "doom",
		config = {
			header = require("configs.dashboard.header"), --your header
			center = require("configs.dashboard.center"), --your center
			footer = require("configs.dashboard.footer"), --your footer
		},
	})
end
