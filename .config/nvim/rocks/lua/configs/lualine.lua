local LUALINE_CONFIGS = {
	options = {
		theme = "auto",
		-- globalstatus = true,
		disabled_filetypes = { statusline = { "dashboard", "alpha" } },
		-- prevent telescope from stealing focus
		ignore_focus = { "TelescopePrompt" },
	},
	buffer_blacklist = { "neo-tree filesystem [1]", "[dap-repl]", "DAP Console", "DAP Watches" },
	buffer_extension_blacklist = {},
	buffer_mode_blacklist = { "t" },
}
local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

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
	for _, mode in ipairs(LUALINE_CONFIGS.buffer_mode_blacklist) do
		if current_buffer_mode == mode then
			return false
		end
	end

	-- INFO: Don't need to check if buffer_name is empty
	if current_buffer_name == "" then
		return false
	end

	-- INFO: Check if current buffer name is in the blacklist
	for _, buffer_name in ipairs(LUALINE_CONFIGS.buffer_blacklist) do
		if current_buffer_name == buffer_name then
			return false
		end
	end

	-- INFO: Check if current buffer extension is in the blacklist
	for _, buffer_extension in ipairs(LUALINE_CONFIGS.buffer_extension_blacklist) do
		if current_buffer_filetype == buffer_extension then
			return false
		end
	end

	return true
end

local lsp_blacklist = {
	"copilot", --INFO: not an lsp
	"pylsp", -- INFO: I only use it for codeactions import
	"ruff_lsp", -- INFO: Not an actual lsp, its a linter I don't want it to crowd the info
}

local current_lsp = function()
	local all_clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() }) or {}
	local attached_clients = {}
	for _, client in pairs(all_clients) do
		local name = client.name
		if name == "pyright" or name == "pylance" then
			local venv_name = require("venv-selector").get_active_venv()
			if venv_name ~= nil then
				venv_name = string.gsub(venv_name, ".*/pypoetry/virtualenvs/*", "")
				venv_name = string.gsub(venv_name, ".*/miniconda3/envs/", "")
				venv_name = string.gsub(venv_name, ".*/miniconda3", "base")
			else
				venv_name = "sys"
			end
			name = name .. "(" .. venv_name .. ")"
		end
		local blacklisted = false
		for _, blacklist_value in pairs(lsp_blacklist) do
			if name == blacklist_value then
				blacklisted = true
				break
			end
		end
		if not blacklisted then
			table.insert(attached_clients, name)
		end
	end
	if #attached_clients > 0 then
		return table.concat(attached_clients, " | ")
	else
		return ""
	end
end

local lualine_a = { "mode" }
local lualine_b = {
	{ "branch", on_click = cmd_on_click("Neogit") },
	{
		"filetype",
		icon_only = true,
		separator = "",
		padding = { left = 1, right = 0 },
		cond = display_file,
	},
	{
		"filename",
		path = 0,
		separator = "",
		padding = { left = 1, right = 1 },
		symbols = { modified = "󱇧", readonly = "󰷊", unnamed = "" },
		cond = display_file,
	},
}
local lualine_c = {}

local lualine_x = {
	{
		current_lsp,
		on_click = cmd_on_click("Neoconf lsp"),
	},
	{
		"diagnostics",
		sources = { "nvim_workspace_diagnostic" },
		symbols = { error = " ", warn = " ", hint = "󰌵 " },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
		sections = { "error", "warn", "hint" },
		always_visible = true,
	},
}
local lualine_y = {
	{
		"tabs",
		mode = 0,
		separators = "",
		cond = function()
			return #vim.api.nvim_list_tabpages() > 1
		end,
		use_mode_colors = true,
	},
}
local lualine_z = { "progress" }

require("lualine").setup({
	options = LUALINE_CONFIGS.options,
	sections = {
		lualine_a = lualine_a,
		lualine_b = lualine_b,
		lualine_c = lualine_c,
		lualine_x = lualine_x,
		lualine_y = lualine_y,
		lualine_z = lualine_z,
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
