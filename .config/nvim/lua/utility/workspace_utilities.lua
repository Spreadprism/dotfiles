local M = {}

local workspaces = require("workspaces")
local env = require("utility.env")
local fu = require("utility.file_utility")

local load_env_variables = function()
	env.set("userHome", env.get("HOME"))
	env.set("workspaceFolder", workspaces.path())
	env.set("workspaceFolderBaseName", workspaces.name())
end

local load_workspace_file = function() end

M.current_workspace_name = function()
	return workspaces.name()
end

M.on_add = function() end

M.on_remove = function() end

M.on_rename = function() end

M.on_open_pre = function() end

M.on_open = function()
	load_env_variables()
	load_workspace_file()

	--Execute Dashboard cmd
	print(M.current_workspace_name())
	vim.cmd("Dashboard")
end

M.currently_in_workspace = function()
	return M.current_workspace_name() ~= nil
end

return M
