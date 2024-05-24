return function(on_attach, capabilities)
	capabilities.offsetEncoding = { "utf-16" }
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	}
end
