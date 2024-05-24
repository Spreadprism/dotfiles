local util = require("lspconfig.util")

return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "markdown", "quarto" },
		root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
	}
end
