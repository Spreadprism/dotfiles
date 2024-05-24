return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "sh", "zsh" },
		settings = {
			{
				root_dir = vim.fn.getcwd(),
			},
		},
	}
end
