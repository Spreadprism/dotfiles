-- Ripgrep wrapper
local M = {}

local execute_rg = function(cmd)
	-- executes rg command and returns a newlines separated list of results
	local handle = io.popen(cmd)
	if handle == nil then
		return {}
	end
	local result = handle:read("*a")
	handle:close()

	local ans = {}

	for line in result:gmatch("[^\r\n]+") do
		table.insert(ans, line)
	end
	return ans
end

M.rg = function(args, base_path)
	base_path = base_path or vim.fn.getcwd()
	return execute_rg("rg " .. args .. " " .. base_path)
end

return M
