local M = {}
local lfs = require("lfs")
-- INFO: luarocks install lua-glob --server=https://luarocks.org/dev --lua-version 5.1
local glob = require("glob")

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

---@param path string
---@return table<string> | nil
M.get_childs = function(path)
	if M.is_dir(path) then
		local childs = {}
		for child in lfs.dir(path) do
			if child ~= "." and child ~= ".." then
				table.insert(childs, child)
			end
		end
		return childs
	else
		return nil
	end
end

---@param path string
---@return table<string> | nil
M.get_directories = function(path)
	local childs = M.get_childs(path)
	if childs == nil then
		return nil
	end

	local directories = {}
	for _, child in pairs(childs) do
		if M.is_dir(path .. "/" .. child) then
			table.insert(directories, child)
		end
	end
end

---@param path string
---@return table<string> | nil
M.get_files = function(path)
	local childs = M.get_childs(path)
	if childs == nil then
		return nil
	end

	local directories = {}
	for _, child in pairs(childs) do
		if M.is_file(path .. "/" .. child) then
			table.insert(directories, child)
		end
	end
end

return M
