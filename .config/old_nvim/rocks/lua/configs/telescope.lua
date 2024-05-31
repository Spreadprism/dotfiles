require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<Tab>"] = require("telescope.actions").move_selection_next,
				["<S-Tab>"] = require("telescope.actions").move_selection_previous,
				["<C-q>"] = require("telescope.actions").close,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = require("utility.ripgrep").find_files_cmd(),
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

local configs_utility = require("utility.configs")
configs_utility.build("telescope-fzf-native.nvim", "make")

require("telescope").load_extension("fzf")

local keybind = require("utility.keybind_manager").Keybind.new
local keybind_group = require("utility.keybind_manager").KeybindGroup.new
local builtin = require("telescope.builtin")

keybind_group("<leader>s", "Search", {
	keybind("n", "f", builtin.find_files, "Search files"),
	keybind("n", "g", builtin.current_buffer_fuzzy_find, "Fuzzy find current buffer"),
}):register()
