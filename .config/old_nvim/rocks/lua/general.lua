vim.g.mapleader = " "
vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showtabline = 0
vim.o.scl = "yes"

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
	signs = {
		--support diagnostic severity / diagnostic type name
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

-- INFO: Defining the signs and highlights after loading plugins to overwrite them.
vim.cmd([[highlight DiagnosticUnderlineError guifg=#db4b4b]])

vim.cmd([[highlight DiagnosticUnderlineWarn guifg=#e0af68]])
vim.cmd([[highlight DiagnosticDeprecated guifg=#e0af68]])

vim.cmd([[highlight DiagnosticUnderlineInfo guifg=#0db9d7]])
vim.cmd([[highlight DiagnosticInfo guifg=#0db9d7]])

vim.cmd([[highlight DiagnosticUnderlineInfo guifg=#1abc9c]])

local keybind = require("utility.keybind_manager").Keybind.new
-- INFO: Generic
keybind("n", "", "<cmd>q<CR>", "Quit"):register()
keybind({ "i", "v" }, ";;", "<Esc>", "Escape iv"):register()
keybind("t", ";;", "<C-\\><C-n>", "Escape term"):register()

-- INFO: Code Navigation
keybind({ "n", "v" }, "L", "g_", "Move cursor to last non-whitespace character"):register()
keybind({ "n", "v" }, "H", "^", "Move cursor to last non-whitespace character"):register()

-- INFO: Code manipulation
keybind("v", "Y", '"+y', "Yank to clipboard"):register()
keybind("n", "<A-J>", "Vyp", "Duplicate line down"):register()
keybind("n", "<A-K>", "VyP", "Duplicate line up"):register()
keybind("v", "<A-J>", "yp", "Duplicate line down"):register()
keybind("v", "<A-K>", "yP", "Duplicate line up"):register()
keybind("n", "<A-o>", "o<ESC>k", "Insert line under"):register()
keybind("n", "<A-O>", "O<ESC>k", "Insert line over"):register()
keybind("v", "<Tab>", ">gv", "Insert table"):register()
keybind("v", "<S-Tab>", "<gv", "Remove tab"):register()
