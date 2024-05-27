local current_lsp = function()
	local all_clients = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() }) or {}

	local displays = {}
	for _, client in pairs(all_clients) do
		local name = client.name
		table.insert(displays, require("utils.lsp").get_display(name))
	end

	return table.concat(displays, " | ")
end

return {
	{
		current_lsp,
		cond = function()
			return current_lsp() ~= nil
		end,
	},
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
}
