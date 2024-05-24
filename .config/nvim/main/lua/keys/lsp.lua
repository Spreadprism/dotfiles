local M = {}

M.n = {
	["<leader>li"] = { ":LspInfo<CR>", "Open lsp info", { silent = true } },
	["<leader>lr"] = { ":LspRestart<CR>", "Restart lsp", { silent = true } },
	["<leader>lS"] = { ":LspStop<CR>", "Stop lsp", { silent = true } },
	["<leader>ls"] = { ":Neoconf lsp<CR>", "Settings", { silent = true } },
	["<leader>le"] = { ":Neoconf<CR>", "Edit settings", { silent = true } },
}

return M
