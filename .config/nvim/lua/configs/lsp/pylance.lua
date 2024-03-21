return function(on_attach, capabilities)
	local env = require("utility.env")
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			require("venv-selector").retrieve_from_cache()
		end,
		on_init = function(client)
			local new_includes = {
				env.get("workspaceFolder"),
				env.get("workspaceFolder") -- Project-Name/project_name
					.. "/"
					---@diagnostic disable-next-line: param-type-mismatch
					.. string.lower(env.get("workspaceFolderBaseName")):gsub("%-", "_"),
			}
			local old_includes = client.config.settings.python.analysis.include

			local merged_includes = {}

			for _, include in ipairs(new_includes) do
				table.insert(merged_includes, include)
			end

			for _, include in ipairs(old_includes) do
				local exists = false
				for _, new_include in ipairs(new_includes) do
					if include == new_include then
						exists = true
						break
					end
				end
				if not exists then
					table.insert(merged_includes, include)
				end
			end

			client.config.settings.python.analysis.include = merged_includes

			return true
		end,
		capabilities = capabilities,
		settings = {
			python = {
				analysis = {
					autoImportCompletions = true,
					autoImportUserSymbols = true,
					indexing = true,
					diagnosticMode = "workspace",
					include = {
						env.get("HOME") .. "/.config/nvim/python",
					},
					packageIndexDepths = {
						{
							name = "",
							depth = 2,
							includeAllSymbols = true,
						},
					},
					diagnosticSeverityOverrides = {
						reportMissingModuleSource = "error",
						reportMissingImports = "error",
						reportUnusedImport = "none",
						reportUnusedClass = "none",
						reportUnusedFunction = "none",
						reportUnusedVariable = "none",
					},
				},
			},
		},
	}
end
