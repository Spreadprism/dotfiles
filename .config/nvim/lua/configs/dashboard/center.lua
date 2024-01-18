return {
	{
		action = "Telescope find_files",
		desc = " Find file",
		icon = "󰈞 ",
		key = "f",
	},
	{
		action = function()
			require("telescope").extensions.workspaces.workspaces()
		end,
		desc = " Find workspace",
		icon = "󱈹 ",
		key = "w",
	},
	{
		action = function()
			vim.cmd("silent !Neorg index")
		end,
		desc = " Notes",
		icon = "󱞁 ",
		key = "c",
	},
	{
		action = "Telescope oldfiles",
		desc = " Recent files",
		icon = "󱋡 ",
		key = "r",
	},
	{
		action = "SessionRestore",
		desc = " Load session",
		icon = " ",
		key = "l",
	},
	{
		action = "cd ~/.dotfiles/.config/nvim",
		desc = " Neovim configs",
		icon = " ",
		key = "c",
	},
	{
		action = "qa",
		desc = " Quit",
		icon = " ",
		key = "q",
	},
}
