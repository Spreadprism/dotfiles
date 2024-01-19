local center = {
	{
		action = function()
			vim.cmd("bd")
			vim.defer_fn(function()
				vim.cmd("Telescope find_files")
			end, 5)
		end,
		desc = " Find file",
		icon = "󰈞 ",
		key = "f",
	},
	{
		action = function()
			vim.cmd("bd")
			vim.defer_fn(function()
				require("utility.telescope_pickers.workspace")()
			end, 5)
		end,
		desc = " Open workspace",
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
		action = function()
			vim.cmd("bd")
			vim.defer_fn(function()
				vim.cmd("Telescope oldfiles")
			end, 5)
		end,
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
			-- If cwd is not nvim config dir, change to it
			if vim.fn.getcwd() ~= vim.fn.expand("~/.dotfiles/.config/nvim") then
				vim.cmd("bd")
				vim.defer_fn(function()
					vim.cmd("cd ~/.dotfiles/.config/nvim")
					vim.cmd("Dashboard")
				end, 5)
			end
		end,
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
