return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		-- tag = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local events = { "TextChanged", "BufReadPost", "BufWritePost" }
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				callback = function()
					-- If filetype is neorg, set the conceallevel to 3 else 0
					if vim.bo.filetype == "norg" then
						vim.wo.conceallevel = 3
					else
						vim.wo.conceallevel = 0
					end
				end,
			})
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					}, -- Loads default behaviour
					["core.concealer"] = {
						config = {
							icon_preset = "diamond",
						},
					}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								Notes = "~/Notes",
								personal = "~/Notes/personal",
								school = "~/Notes/school",
								-- classes
								MTI840 = "~/Notes/school/MTI840",
								MGR850 = "~/Notes/school/MGR850",
							},
							default_workspace = "Notes",
						},
					},
				},
			})
		end,
	},
}
