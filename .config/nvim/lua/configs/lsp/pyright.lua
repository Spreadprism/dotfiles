return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			python = {
				pythonPath = require("utility.python_env_manager").get_python_path(),
				reportUnusedImport = "warning",
				analysis = {
					extraPaths = { vim.fn.getcwd() },
					autoImportCompletions = true,
					indexing = true,
					packageIndexDepths = {
						{
							name = "",
							depth = 3,
						},
					},
					diagnosticSeverityOverrides = {
						reportUnusedImport = "false",
						reportUnusedClass = "false",
						reportUnusedFunction = "false",
						reportUnusedVariable = "false",
					},
				},
			},
		},
	}
end
