local M = {}

M.on_start = function()
	local possession_session = require("possession.session")
	local cwd = vim.fn.getcwd()
	cwd = string.gsub(cwd, "/", "_")

	if possession_session.exists(cwd) then
		possession_session.load(cwd)
	else
		possession_session.save(cwd, { no_confirm = true })
	end
end

M.on_save = function()
	local possession_session = require("possession.session")
	local cwd = vim.fn.getcwd()
	cwd = string.gsub(cwd, "/", "_")

	possession_session.save(cwd, { no_confirm = true })
end

return M
