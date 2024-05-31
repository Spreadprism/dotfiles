local lsp_blacklist = {}

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_namespace("UserLspConfig"),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }
		keybind("n", "K", vim.lsp.buf.hover, "Show hover information", opts):register()
		keybind("n", "<f2>", vim.lsp.buf.rename, "Show hover information", opts):register()

		local lspgroup = keybind_group("<leader>l", "language server")
		lspgroup:register({
			keybind({ "n", "v" }, "a", vim.lsp.buf.code_action, "Show code actions", opts),
		})
	end,
})

require("utils.lsp").setup_all_lsp()
