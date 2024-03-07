local ignore_patterns = {
	".git/*",
	"**/node_modules/*",
	"/target/*",
	".next/*",
	".venv",
	"**/__pycache__/*",
	"**/.pytest_cache/*",
	"**/.ruff_cache/*",
}

local function get_find_files_command()
	local find_files_rg = {
		"rg",
		"-uuu",
		"--files",
		"--hidden",
	}

	for _, pattern in pairs(ignore_patterns) do
		table.insert(find_files_rg, "--glob")
		table.insert(find_files_rg, "!" .. pattern)
	end

	return find_files_rg
end

return function()
	local trouble = require("trouble.providers.telescope")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<Tab>"] = require("telescope.actions").move_selection_next,
					["<S-Tab>"] = require("telescope.actions").move_selection_previous,
					["<C-q>"] = require("telescope.actions").close,
					["<c-t>"] = trouble.open_with_trouble,
				},
			},
		},
		pickers = {
			find_files = {
				find_command = get_find_files_command(),
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
end
