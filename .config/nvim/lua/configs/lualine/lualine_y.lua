return {
	-- {
	-- 	require("utility.os").icon,
	-- },
	{
		"tabs",
		mode = 0,
		separators = "",
		cond = function()
			return #vim.api.nvim_list_tabpages() > 1
		end,
		use_mode_colors = true,
		-- tabs_color = {
		-- 	inactive = { bg = "#3b4261" }, -- Color for inactive tab.
		-- 	active = { fg = "#e4ac6c", bg = "#3b4261" }, -- Color for inactive tab.
		-- },
	},
	-- function()
	-- 	return require("copilot_status").status_string()
	-- end,
}
