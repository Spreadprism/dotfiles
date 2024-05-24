local M = {}

M.BASE_NEOVIM_LUA_PATH = require("utility.env").get("HOME") .. "/.config/nvim/lua"

local is_dir = function(path)
	local lfs = require("lfs")
	-- lfs.attributes will error on a filename ending in '/'
	return path:sub(-1) == "/" or lfs.attributes(path, "mode") == "directory"
end
M.get_modules_in_dir = function(path, base_path)
	-- Check if supplied path is actually a directory
	if base_path == nil then
		base_path = ""
	end

	if not is_dir(path) then
		print(path .. " is not a directory")
		return {}
	end

	local lfs = require("lfs")
	local modules = {}
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			local extension = string.match(file, "%.lua$")
			if extension then
				local module_name = base_path .. string.gsub(file, "%.lua$", "")
				table.insert(modules, module_name)
			end
		end
	end
	return modules
end

return M
