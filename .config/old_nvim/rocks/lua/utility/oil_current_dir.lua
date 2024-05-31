local M = {}
local HOME = os.getenv("HOME")
local USER = os.getenv("USER")
M.get_current_dir = function()
	local ok, oil = pcall(require, "oil")
	local dir = nil
	if ok then
		dir = oil.get_current_dir()
		if dir ~= nil then
			local cwd = vim.fn.getcwd()
			local cwd_dir_name = vim.fn.fnamemodify(cwd, ":t")
			dir = string.gsub(dir, cwd, "/" .. cwd_dir_name)
			dir = string.gsub(dir, HOME, "~")

			-- remove trailing slash
			dir = string.gsub(dir, "/$", "")

			dir = " " .. dir
		end
	end
	return dir or ""
end
return M
