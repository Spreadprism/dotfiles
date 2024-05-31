return function(on_attach, capabilities)
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
