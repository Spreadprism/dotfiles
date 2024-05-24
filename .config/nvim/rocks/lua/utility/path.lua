local M = {}
local lfs = require("lfs")
local ripgrep = require("utility.ripgrep")

local ripgrep_available = ripgrep.is_available()

---@param path string
---@return boolean
M.exists = function(path)
	local attr = lfs.attributes(path)
	return attr ~= nil
end
---@param path string
---@return boolean
M.is_valid_path = function(path)
	if path == nil then
		return false
	end
	return M.exists(path)
end

---@param path string
---@return boolean
M.is_dir = function(path)
	return M.is_valid_path(path) and lfs.attributes(path).mode == "directory"
end

---@param path string
---@return boolean
M.is_file = function(path)
	return M.is_valid_path(path) and lfs.attributes(path).mode == "file"
end

M.get_parent_directory = function(path)
	-- example path : /home/user/something -> /home/user
	-- example file path : /home/user/something/file.txt -> /home/user/something
	local parent_directory = path:match("(.*)/")
	return parent_directory
end

M.get_files = function(path, depth, glob, require_ripgrep)
	require_ripgrep = require_ripgrep or false
	depth = depth or 1
	local files = {}
	if not ripgrep_available then
		if depth ~= depth or glob ~= nil then
			error("ripgrep is required for depth and glob options")
			return
		end
		if require_ripgrep then
			error("ripgrep is not available and argument require_ripgrep is true")
			return
		end

		for file in lfs.dir(path) do
			if file ~= "." and file ~= ".." then
				local file_path = path .. file
				table.insert(files, file_path)
			end
		end
	else
		glob = glob or "*"
		files = ripgrep.rg('--files --glob "' .. glob .. '" --max-depth=' .. depth, path)
	end
	return files
end

M.is_empty_dir = function(path)
	if not M.is_dir(path) then
		return false
	end

	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			return false
		end
	end
	return true
end

return M
