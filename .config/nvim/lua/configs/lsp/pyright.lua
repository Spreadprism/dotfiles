return function(on_attach, capabilities)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
			if venv ~= "" then
				require("venv-selector").retrieve_from_cache()
			end
		end,
		capabilities = capabilities,
		settings = {
			python = {
				pythonPath = require("utility.env").get("HOME") .. "/miniconda3/bin/python",
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
