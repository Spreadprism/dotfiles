keybind_group("<leader>s", "Search"):register({
	keybind("n", "f", require("telescope.builtin").find_files, "Search files"),
})
