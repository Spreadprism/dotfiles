-- INFO: General configuration
vim.g.mapleader = " "
vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showtabline = 0
vim.o.updatetime = 300
vim.o.scl = "yes"

-- TODO: Should be removed later on when plugins are updated
vim.deprecate = function() end

local env = require("utility.env")
local session_id = require("utility.instance_manager").get_session_id()
env.set("userHome", env.get("HOME"))
env.set("nvimHome", env.get("HOME") .. "/.config/nvim")
env.set("NVIM_SESSION_ID", session_id)

local set_workspace = function()
	local workspace = vim.fn.getcwd()
	env.set("workspaceFolder", workspace)
	env.set("workspaceFolderBaseName", vim.fn.fnamemodify(workspace, ":t"))
end

set_workspace()
vim.api.nvim_create_autocmd("DirChanged", {
	callback = set_workspace,
})

if vim.fn.executable("delance-langserver") == 1 then
	env.set("DELANCE_EXISTS", "true")
end

-- INFO: Init packages
require("init_lazy")
-- INFO: Init keybinds
require("keybinds_manager").init_keybinds()
-- INFO: Init filetypes
require("init_filetypes")

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

vim.cmd([[autocmd DirChanged * call chansend(v:stderr, printf("\033]7;file://%s\033\\", v:event.cwd))]])