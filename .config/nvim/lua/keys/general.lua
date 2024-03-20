local M = {}

-- Available options silent & noremap
M.n = {
	["<leader>olg"] = { "<cmd>LazyGit<CR>", "Open lazygit" },
	["<leader>ot"] = { "<cmd>TroubleToggle<CR>", "Open trouble" },
	["?"] = { "<cmd>noh<CR>", "Clear highlight" },
	["<M-/>"] = { "*", "Search next word" },
	["<M-,>"] = { "N", "Previous search" },
	["<M-.>"] = { "n", "Next search" },
	-- ["<leader>oD"] = { "<cmd>LazyDocker<CR>", "Open lazydocker" },
	["<leader>od"] = { "<cmd>Dashboard<CR>", "Open dashboard" },
	["<leader>os"] = { "<cmd>DBUIToggle<cr>", "Open sql" },
	["<C-s>"] = { "<cmd>w<CR>", "Save file" },
	-- moving
	["L"] = { "g_", "move the cursor to the last non-whitespace character", { noremap = true } },
	["H"] = { "^", "move the cursor to the first non-whitespace character", { noremap = true } },
	-- closing and saving
	["<C-q>"] = { "<CMD>q<CR>", "close", { silent = true } },
	["<leader>e"] = {
		function()
			if vim.bo.filetype == "dashboard" then
				vim.cmd("bd")
			end

			vim.cmd("Neotree filesystem toggle left")
		end,
		"Toggle neovim file explorer",
		{ noremap = true, silent = true },
	},
	["<leader>E"] = {
		function()
			vim.cmd("Neotree filesystem toggle left reveal")
		end,
		"Toggle neovim file explorer with current buffer as focus",
		{ noremap = true, silent = true },
	},
	-- ["<leader>e"] = {
	-- 	function()
	-- 		vim.cmd("Telescope file_browser")
	-- 	end,
	-- 	"Toggle neovim file explorer",
	-- 	{ noremap = true, silent = true },
	-- },
	-- ["<leader>E"] = {
	-- 	function()
	-- 		vim.cmd("Telescope file_browser path=%:p:h select_buffer=true")
	-- 	end,
	-- 	"Toggle neovim file explorer with current buffer as focus",
	-- 	{ noremap = true, silent = true },
	-- },
	-- file keymaps
	["<M-e>"] = {
		function()
			if not MiniFiles.close() then
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			end
		end,
		"Toggle neovim file explorer with current buffer as focus",
		{ noremap = true, silent = true },
	},
	-- ["<M-e>"] = {
	-- 	function()
	-- 		vim.cmd("silent !thunar $PWD")
	-- 	end,
	-- 	"Toggle file explorer with workspace directory as focus",
	-- 	{ noremap = true, silent = true },
	-- },
	["<M-v>"] = { "<CMD>vsplit<CR>", "Vertical split" },
	["<M-V>"] = { "<CMD>split<CR>", "Horizontal split" },
	["<C-;>"] = { "<esc>", "Escape" },
	["<C-Left>"] = {
		function()
			require("smart-splits").resize_left()
		end,
		"Horizontal split",
	},
	["<C-Right>"] = {
		function()
			require("smart-splits").resize_right()
		end,
		"Horizontal split",
	},
	["<C-Down>"] = {
		function()
			require("smart-splits").resize_down()
		end,
		"Horizontal split",
	},
	["<C-Up>"] = {
		function()
			require("smart-splits").resize_up()
		end,
		"Horizontal split",
	},

	["<leader>ff"] = {
		"<CMD>Format<CR>",
		"format",
	},
	["tn"] = {
		"<CMD>tabnew<CR>",
		"New tab",
	},
	["T"] = {
		"<cmd>terminal<CR>i",
		"Convert current buffer to terminal",
		{ silent = true },
	},
	["tt"] = {
		"<CMD>tabnew +terminal<CR>i",
		"new terminal tab",
	},
	["tl"] = {
		"<CMD>tabnext<CR>",
		"Next tab",
	},
	["th"] = {
		"<CMD>tabprevious<CR>",
		"Previous tab",
	},
	-- Buffers manipulation
	-- ["<leader>xx"] = {":bd!<CR>", "Close current buffer", {noremap = true, silent = true}},
	-- ["<leader>xa"] = {":%bd<CR>", "Close all buffers", {noremap = true, silent = true}},
	-- ["<leader>xo"] = {":%bd|e#|bd#<CR>", "Close other buffers", {noremap = true, silent = true}},
	["<leader>ol"] = { "<CMD>Lazy<CR>", "Open Lazy", { silent = true } },
	["<leader>oM"] = { "<CMD>Mason<CR>", "Open Mason", { silent = true } },
	["<leader>op"] = {
		"<cmd>PlantumlOpen<CR>",
		"Open plantuml preview",
		{ silent = true },
	},
	["<leader>oq"] = {
		function()
			local current_workspace = require("utility.neorg_dirman").get_current_workspace()[1]
			if current_workspace ~= "quicknote" then
				vim.cmd("Neorg workspace quicknote")
			end
			vim.cmd("Neorg index")
		end,
		"Open quicknote",
	},
	["<leader>on"] = {
		function()
			local current_workspace = require("utility.neorg_dirman").get_current_workspace()[1]
			if current_workspace ~= "Notes" then
				vim.cmd("Neorg workspace Notes")
			end
			vim.cmd("Neorg index")
		end,
		"Open quicknote",
	},
	["<leader>xp"] = {
		function()
			local bufname = vim.api.nvim_buf_get_name(0)
			-- Split the path by '/'
			local parts = {}
			for part in string.gmatch(bufname, "([^/]+)") do
				table.insert(parts, part)
			end

			-- Get the last part (the filename without extension)
			local filenameWithoutExtension = parts[#parts]

			-- Extract the filename (without extension) from the last part
			local filename = string.match(filenameWithoutExtension, "([^%.]+)")
			filename = filename .. ".png"
			vim.cmd("silent! PlantumlSave " .. filename)
			print("Saved to file " .. filename)
		end,
		"Export plantuml",
	},
	["<leader>rt"] = {
		"<cmd>OverseerRun<CR>",
		"Run task",
		{ silent = true },
	},
	["<leader>oo"] = {
		"<cmd>OverseerToggle<CR>",
		"Open Overseer",
		{ silent = true },
	},
}
M.i = {
	["<C-e>"] = { "<esc>A", "Go to end of line", { silent = true } },
	["<C-s>"] = { "<esc>^", "Go to first char of line", { silent = true } },
	["<C-o>"] = { "<esc>o", "Insert line bellow", { silent = true } },
	["<S-Tab>"] = { "<C-H>", "Remove tab", { silent = true } },
}

M.v = {
	-- code manipulation
	["<Tab>"] = { ">gv", "Add tab", { silent = true } },
	["<S-Tab>"] = { "<gv", "Remove tab", { silent = true } },
	-- ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move down", { silent = true } },
	-- ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move up", { silent = true } },
	-- ["<A-l>"] = { ":m '>+1<CR>gv=gv", "Move right", { silent = true } },
	-- ["<A-h>"] = { ":m '<-2<CR>gv=gv", "Move left", { silent = true } },
	["<A-J>"] = { "yp", "Copy down", { silent = true } },
	["<A-K>"] = { "yP", "Copy up", { silent = true } },
	["/"] = { "gcgv", "toggle comment", {}, true },
	["L"] = { "g_", "move the cursor to the last non-whitespace character", { noremap = true } },
	["Y"] = { '"+y', "Yank to clipboard", { silent = true } },
}

M.t = {
	["<M-;>"] = {
		"<C-\\><C-n>",
		"Escape terminal",
	},
}

return M
