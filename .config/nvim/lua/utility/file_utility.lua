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

---@param paths table<string>
---@param pattern string | table<string>
---@param options table | nil
---@return table<string> | nil
local filter = function(paths, pattern, options)
	local matches = {}
	if options == nil then
		options = {}
	end
	local parser = glob.glob(pattern, options)
	for _, file in pairs(paths) do
		if parser(file) then
			table.insert(matches, file)
		end
	end
	return matches
end

---@param path string
---@param pattern string | table<string> | nil
---@param options table | nil
---@return table<string> | nil
M.get_childs = function(path, pattern, options)
	if M.is_dir(path) then
		local childs -- table<string> | nil
		childs = {}
		for child in lfs.dir(path) do
			if child ~= "." and child ~= ".." then
				table.insert(childs, child)
				if M.is_dir(path .. "/" .. child) then
					local child_child = M.get_childs(path .. "/" .. child)
					if child_child ~= nil then
						for _, c in pairs(child_child) do
							table.insert(childs, child .. "/" .. c)
						end
					end
				end
			end
		end

		if pattern ~= nil then
			childs = filter(childs, pattern, options)
		end

		return childs
	else
		return nil
	end
end

---@param path string
---@param pattern string | table<string>
---@param options table | nil
---@return table<string> | nil
M.get_directories = function(path, pattern, options)
	local childs = M.get_childs(path, pattern, options)
	if childs == nil then
		return nil
	end

	local directories = {}
	for _, child in pairs(childs) do
		if M.is_dir(path .. "/" .. child) then
			table.insert(directories, child)
		end
	end
	return directories
end

---@param path string
---@return table<string> | nil
M.get_files = function(path, pattern, options)
	local childs = M.get_childs(path, pattern, options)
	if childs == nil then
		return nil
	end

	local files = {}
	for _, child in pairs(childs) do
		if M.is_file(path .. "/" .. child) then
			table.insert(files, child)
		end
	end
	return files
end

return M
