return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
		cmd = { "typescript-language-server", "--stdio" },
	}
end
