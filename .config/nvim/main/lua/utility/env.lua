-- INFO: This is a simple wrapper around os.getenv which allows us to set env vars in lua

local M = {}
local vars = {}

M.set = function(key, value)
	vars[key] = value
end

M.get = function(key)
	local val = vars[key]
	if val == nil then
		val = os.getenv(key)
		if val ~= nil then
			M.set(key, val)
		end
	end

	return val
end

return M
