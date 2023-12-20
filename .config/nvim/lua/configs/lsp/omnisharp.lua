return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { os.getenv("HOME") .. "/.local/share/nvim/mason/bin/omnisharp" },
	}
end
