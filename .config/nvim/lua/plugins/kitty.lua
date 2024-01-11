local kitty_plugins = {
	{
		"3rd/image.nvim",
		event = "VeryLazy",
		config = function()
			require("image").setup({
				backend = "kitty",
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
					neorg = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "norg" },
					},
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "", "cmd" },
				editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
				tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
				-- hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
				hijack_file_patterns = {}, -- render image files as images when opened
			})
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
			markdown = {
				url_encode_path = true,
				template = "![$CURSOR]($FILE_PATH)",

				drag_and_drop = {
					download_images = true,
				},
			},
			norg = {
				url_encode_path = true,
				template = ".image $FILE_PATH",

				drag_and_drop = {
					download_images = true,
				},
			},
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
		},
	},
}

local env = require("utility.env")

if env.get("TERM") == "xterm-kitty" then
	return kitty_plugins
else
	return {}
end
