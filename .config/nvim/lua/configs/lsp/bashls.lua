return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			{
				root_dir = vim.fn.getcwd(),
				bashIde = {
					globPattern = "!(*.env|*@(.sh|.inc|.bash|.command))",
				},
			},
		},
	}
end
