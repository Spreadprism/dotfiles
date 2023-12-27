local overseer = require("overseer")
local env = require("utility.env")
local file_utility = require("utility.file_utility")

local cs_build_task_name = "C# build debug"
overseer.register_template({
	name = cs_build_task_name,
	---@diagnostic disable-next-line: unused-local
	builder = function(params)
		return {
			cmd = { "dotnet" },
			args = { "build" },
			name = "C# build debug",
		}
	end,
})

local get_program = function()
	local bin_path = env.get("workspaceFolder") .. "/bin"
	local program_name = env.get("workspaceFolderBaseName")

	local pattern = "/Debug/*/" .. program_name .. ".dll"
	local possible_files = file_utility.get_files(bin_path, pattern)

	if #possible_files == 0 then
		print("No debug dll found")
		return nil
	elseif #possible_files > 1 then
		print("Multiple debug dlls found")
		return nil
	else
		---@diagnostic disable-next-line: need-check-nil
		local program_binary = possible_files[1]
		return bin_path .. "/" .. program_binary
	end
end

return {
	{
		name = "(NVIM-CONFIG) Launch debug",
		type = "coreclr",
		request = "launch",
		cwd = "${workspaceFolder}",
		terminal = "integrated",
		console = "integratedTerminal",
		stopOnEntry = false,
		program = get_program,
		preLaunchTask = cs_build_task_name,
	},
}
