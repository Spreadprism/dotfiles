return {
	{
		action = function()
			require("persistence").load()
		end,
		desc = " Load Session",
		icon = "󰈞 ",
		key = "l",
	},
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
		action = "qa",
		desc = " Quit",
		icon = " ",
		key = "q",
	},
}
