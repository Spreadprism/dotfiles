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

local blacklist = {
	"copilot", --INFO: not an lsp
	"pylsp", -- INFO: I only use it for codeactions import
	"ruff_lsp", -- INFO: Not an actual lsp, its a linter I don't want it to crowd the info
}
-- -- LSP clients attached to buffer
-- local clients_lsp = function()
-- 	local bufnr = vim.api.nvim_get_current_buf()
-- 	local clients = vim.lsp.buf_get_clients(bufnr)
-- 	if next(clients) == nil then
-- 		clients = {}
-- 	end
-- 	local c = {}
-- 	for _, client in pairs(clients) do
-- 		local name = client.name
-- 		if name == "pyright" then
-- 			name = name .. "(" .. require("utility.python_env_manager").get_venv_dir_name() .. ")"
-- 		end
-- 		local blacklisted = false
-- 		for _, blacklist_value in pairs(blacklist) do
-- 			if name == blacklist_value then
-- 				blacklisted = true
-- 				break
-- 			end
-- 		end
-- 		if not blacklisted then
-- 			table.insert(c, name)
-- 		end
-- 	end
--
-- 	if #c > 0 then
-- 		return " " .. table.concat(c, " | ")
-- 	else
-- 		return " " .. "No lsp"
-- 	end
-- end

local current_lsp = function()
	local current_buffer = require("utility.buffer_info").buffer_number()
	local all_clients = vim.lsp.get_clients({ bufnr = current_buffer }) or {}

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
				venv_name = "base"
			end
			name = name .. "(" .. venv_name .. ")"
		end

		local blacklisted = false
		for _, blacklist_value in pairs(blacklist) do
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
		return " " .. table.concat(attached_clients, " | ")
	else
		return nil
	end
end

local display_lsp = function()
	return current_lsp() ~= nil
end

local status_to_color = {
	idle = colors.blue,
	loading = colors.green,
	error = colors.red,
	warning = colors.orange,
}
local get_copilot_color = function()
	local status = require("copilot_status").status().status
	local color = nil
	for key, val in pairs(status_to_color) do
		if key == status then
			color = { fg = val }
		end
	end
	return color
end

local overseer = require("overseer")
return {
	{
		"overseer",
		unique = true,
		symbols = {
			[overseer.STATUS.RUNNING] = "󰦖 ",
		},
	},
	{
		require("copilot_status").status_string,
		color = get_copilot_color,
	},
	{
		current_lsp,
		cond = display_lsp,
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
		cond = function()
			return require("utility.buffer_info").filetype() ~= "norg"
		end,
		on_click = function(n_clicks, mouse_button, modifiers)
			if mouse_button == "l" then
				vim.cmd("TroubleToggle")
			end
		end,
	},
}
