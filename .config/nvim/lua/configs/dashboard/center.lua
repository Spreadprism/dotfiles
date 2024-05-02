local center = {
	{
		action = function()
			vim.cmd("only")
			require("utility.telescope_pickers.workspace")()
		end,
		desc = " Open workspace",
		icon = "󱈹 ",
		key = "w",
	},
	{
		action = function()
			vim.cmd("only")
			vim.cmd("Telescope find_files")
		end,
		desc = " Find file",
		icon = "󰈞 ",
		key = "f",
	},
	{
		action = function()
			vim.cmd("only")
			vim.cmd("Telescope oldfiles")
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
			-- list all buffer of filetype dashboardpreview
			vim.cmd("only")
			vim.cmd("Neogit")
		end,
		desc = " Neogit",
		icon = "󰊢 ",
		key = "g",
	},
	{
		action = function()
			-- list all buffer of filetype dashboardpreview
			vim.cmd("only")
			vim.cmd("Leet")
		end,
		desc = " Leetcode",
		icon = "󰓾 ",
		key = "L",
	},
	-- {
	-- 	action = "Neorg index",
	-- 	desc = " Notes",
	-- 	icon = "󱞁 ",
	-- 	key = "n",
	-- },
	{
		action = function()
			-- If cwd is not nvim config dir, change to it
			if vim.fn.getcwd() ~= vim.fn.expand("~/.dotfiles/.config/nvim") then
				vim.cmd("only")
				vim.cmd("cd ~/.dotfiles/.config/nvim")
				vim.cmd("Dashboard")
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
