local session_id = vim.fn.localtime()
local M = {}

M.get_session_id = function()
	return session_id
end

return M
