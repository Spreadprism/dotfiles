local M = {}

local path_packages = vim.fn.stdpath("data") .. "/site/pack/rocks/start/"
local path_utils = require("utility.path")

M.build = function(plugin_name, command)
	local plugin_path = path_packages .. plugin_name
	if path_utils.exists(path_packages) and not path_utils.exists(plugin_path .. "/build") then
		os.execute("cd " .. plugin_path .. " && " .. command)
	end
end
return M
