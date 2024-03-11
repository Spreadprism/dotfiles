return function(on_attach, capabilities)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			require("venv-selector").retrieve_from_cache()
		end,
		capabilities = capabilities,
	}
end
