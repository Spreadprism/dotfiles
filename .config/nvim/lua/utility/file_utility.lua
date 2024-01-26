local M = {}
-- INFO: luarocks install lua-glob --server=https://luarocks.org/dev --lua-version 5.1

---@param path string
---@return boolean
M.exists = function(path)
	local lfs = require("lfs")
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
	local lfs = require("lfs")
	return M.is_valid_path(path) and lfs.attributes(path).mode == "directory"
end

M.is_empty_dir = function(path)
	if not M.is_dir(path) then
		return false
	end

	local lfs = require("lfs")
	for file in lfs.dir(path) do
		if file ~= "." and file ~= ".." then
			return false
		end
	end
	return true
end

---@param path string
---@return boolean
M.is_file = function(path)
	local lfs = require("lfs")
	return M.is_valid_path(path) and lfs.attributes(path).mode == "file"
end

M.get_parent_directory = function(path)
	-- example path : /home/user/something -> /home/user
	-- example file path : /home/user/something/file.txt -> /home/user/something
	local parent_directory = path:match("(.*)/")
	return parent_directory
end

return M
