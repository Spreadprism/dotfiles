local overseer = require("overseer")
-- local env = require("utility.env")
-- local file_utility = require("utility.file_utility")
local env = require("utility.env")

local get_binary = function()
	local directory = vim.fn.getcwd()
	-- local program_name = string.match(directory, "[^/]+$")
	local program_name = env.get("workspaceFolderBaseName")
	local program = directory .. "/target/debug/" .. program_name
	return program
end

overseer.register_template({
	name = "Rust build debug",
	---@diagnostic disable-next-line: unused-local
	builder = function(params)
		return {
			cmd = { "cargo" },
			args = { "build" },
			name = "Rust build debug",
		}
	end,
})

return {
	{
		name = "(NVIM-CONFIG) Launch debug",
		type = "codelldb",
		request = "launch",
		cwd = "${workspaceFolder}",
		terminal = "integrated",
		console = "integratedTerminal",
		stopOnEntry = false,
		program = get_binary,
		preLaunchTask = "Rust build debug",
	},
}
