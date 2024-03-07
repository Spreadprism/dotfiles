return {
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	-- commit = "9f8062c",
	-- 	config = function()
	-- 		require("chatgpt").setup(require("configs.chatgpt"))
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"folke/trouble.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- },
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		opts = {
			show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
			language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
			-- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
			-- temperature = 0.1,
		},
		event = "VeryLazy",
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<M-a>",
						dismiss = "<M-d>",
						next = "<M-l>",
						prev = "<M-h>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		event = "VeryLazy",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_status").setup({
				icons = {
					idle = " ",
					error = " ",
					offline = " ",
					warning = " ",
					loading = " ",
				},
				debug = false,
			})
		end,
	},
}
