local center = {
	{
		action = "Telescope find_files",
		desc = " Find file",
		icon = "󰈞 ",
		key = "f",
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
		action = function()
			require("telescope").extensions.workspaces.workspaces()
		end,
		desc = " Find workspace",
		icon = "󱈹 ",
		key = "w",
	},
	{
		action = "Neorg index",
		desc = " Notes",
		icon = "󱞁 ",
		key = "n",
	},
	{
		action = "cd ~/.dotfiles/.config/nvim",
		desc = " Neovim configs",
		icon = " ",
		key = "c",
	},
	{
		action = "bd",
		desc = " Close dashboard",
		icon = " ",
		key = "x",
	},
	{
		action = "qa",
		desc = " Quit",
		icon = " ",
		key = "q",
	},
}

for _, button in ipairs(center) do
	button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
	button.key_format = "  %s"
end

return center
