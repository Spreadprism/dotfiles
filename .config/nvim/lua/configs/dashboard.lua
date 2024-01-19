local headers_dir_path = vim.fn.stdpath("data") .. "/headers/"
local file_utility = require("utility.file_utility")
local terminal_width = 120
local env = require("utility.env")

if not file_utility.exists(headers_dir_path) then
	vim.cmd("silent !mkdir " .. headers_dir_path)
end

local get_cwd_name = function()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end
local get_header_path = function()
	return headers_dir_path .. env.get("NVIM_SESSION_ID") .. ".txt"
end

local update_header = function()
	local header_path = get_header_path()

	vim.cmd("silent !rm -f" .. header_path)
	local figlet_cmd = "figlet -c -w "
		.. terminal_width
		.. " -f 'ANSI Shadow' "
		.. get_cwd_name()
		.. " > "
		.. header_path
	vim.cmd("silent !" .. figlet_cmd)
end

local setup = function()
	update_header()
	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			pattern = "DashboardLoaded",
			callback = function()
				require("lazy").show()
			end,
		})
	end

	require("dashboard").setup({
		theme = "doom",
		config = {
			-- header = require("configs.dashboard.header"), --your header
			center = require("configs.dashboard.center"), --your center
			footer = require("configs.dashboard.footer"), --your footer
		},
		hide = {
			statusline = false,
		},
		preview = {
			command = "cat | lolcat",
			file_path = get_header_path(),
			file_width = terminal_width,
			file_height = 6,
		},
	})
end
return function()
	setup()
	vim.api.nvim_create_autocmd("DirChanged", {
		pattern = "global",
		callback = function()
			update_header()
			-- if on dashboard we need to close it then repoen it
			if vim.bo.filetype == "dashboard" then
				vim.cmd("bd")
				vim.cmd("Dashboard")
			end
		end,
	})
	-- when nvim closes we need to delete the header file
	vim.api.nvim_create_autocmd("VimLeave", {
		pattern = "*",
		callback = function()
			vim.cmd("!rm -f " .. get_header_path())
		end,
	})
end
