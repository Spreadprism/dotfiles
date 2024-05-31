local M = {}

M.cmd = function(cmd)
	local figlet_cmd = "figlet " .. cmd
	vim.cmd("silent !" .. figlet_cmd)
end

return M
