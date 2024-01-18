lfs = require("utility.file_utility")

local setup = function()
	local header_path = vim.fn.stdpath("data") .. "/header"
	local current_os = require("utility.os").os()

	if not lfs.exists(header_path) then
		vim.cmd("silent !rm " .. header_path)

		if current_os == "Ubuntu" then
			vim.cmd("silent !neofetch --ascii_distro ubuntu_old -L > " .. header_path)
		else
			vim.cmd("silent !neofetch -L > " .. header_path)
		end
	end

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
			file_path = header_path,
			file_width = 42,
			file_height = 20,
		},
	})
end
return function()
	setup()
	vim.api.nvim_create_autocmd("DirChanged", {
		pattern = "global",
		callback = function()
			setup()
		end,
	})
end
