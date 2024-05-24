local buffer_blacklist = { "neo-tree filesystem [1]", "[dap-repl]", "DAP Console", "DAP Watches" }
local buffer_extension_blacklist = {}
local buffer_mode_blacklist = { "t" }

local cmd_on_click = function(cmd)
	return function(_, mouse_button, _)
		if mouse_button == "l" then
			vim.cmd(cmd)
		end
	end
end
local display_file = function()
	local current_buffer_mode = vim.api.nvim_get_mode().mode
	local current_buffer_name = vim.fn.expand("%:t")
	local current_buffer_filetype = vim.bo.filetype

	-- INFO: Check if current buffer mode is in the blacklist
	for _, mode in ipairs(buffer_mode_blacklist) do
		if current_buffer_mode == mode then
			return false
		end
	end

	-- INFO: Don't need to check if buffer_name is empty
	if current_buffer_name == "" then
		return false
	end

	-- INFO: Check if current buffer name is in the blacklist
	for _, buffer_name in ipairs(buffer_blacklist) do
		if current_buffer_name == buffer_name then
			return false
		end
	end

	-- INFO: Check if current buffer extension is in the blacklist
	for _, buffer_extension in ipairs(buffer_extension_blacklist) do
		if current_buffer_filetype == buffer_extension then
			return false
		end
	end

	return true
end

require("lualine").setup({
	options = {
		theme = "auto",
		-- globalstatus = true,
		disabled_filetypes = { statusline = { "dashboard", "alpha" } },
		-- prevent telescope from stealing focus
		ignore_focus = { "TelescopePrompt" },
	},

	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"branch",
				on_click = cmd_on_click("Neogit"),
			},
			{
				"filetype",
				icon_only = true,
				separator = "",
				padding = { left = 1, right = 1 },
				cond = display_file,
			},
			{
				"filename",
				path = 0,
				separator = "",
				padding = { left = 0, right = 1 },
				symbols = { modified = "󱇧", readonly = "󰷊", unnamed = "" },
				cond = display_file,
			},
		},
		lualine_c = {},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_workspace_diagnostic" },
				symbols = { error = " ", warn = " ", hint = "󰌵 " },
				diagnostics_color = {
					color_error = { fg = "#ec5f67" },
					color_warn = { fg = "#ECBE7B" },
					color_info = { fg = "#008080" },
				},
				sections = { "error", "warn", "hint" },
				always_visible = true,
			},
		},
		lualine_y = {
			{
				"tabs",
				mode = 0,
				separators = "",
				cond = function()
					return #vim.api.nvim_list_tabpages() > 1
				end,
				use_mode_colors = true,
			},
		},
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "progress" },
	},
})
