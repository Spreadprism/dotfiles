local rules_to_ignore = {
	"E999",
}

return function(on_attach, capabilities)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.hoverProvider = false
		end,
		capabilities = capabilities,
		init_options = {
			settings = {
				-- Any extra CLI arguments for `ruff` go here.
				args = {
					-- "--ignore",
					-- table.concat(rules_to_ignore, ","),
				},
			},
		},
	}
end
