require("neogit").setup({
  			disable_hint = true,
			integrations = {
				telescope = true,
				diffview = true,
			},
			graph_style = "unicode",
			mappings = {
				finder = {
					["<tab>"] = "Next",
					["<s-tab>"] = "Previous",
				},
			},
})
