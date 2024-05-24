return function(on_attach, capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			json = {
				format = {
					enable = true,
				},
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	}
end
