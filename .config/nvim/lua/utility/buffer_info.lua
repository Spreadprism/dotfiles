local M = {}

local last_buffer_number = function()
	return vim.fn.bufnr("$")
end

M.last_buffer_name = function()
	local last_buffer_name = vim.fn.bufname(last_buffer_number())
	return last_buffer_name
end

M.buffer_number = function()
	local buffer_number = vim.fn.bufnr()
	if buffer_number == -1 then
		buffer_number = nil
	end
	return buffer_number
end

M.name = function()
	-- without extension
	local name = vim.fn.expand("%:t:r")
	return name
end

M.full_name = function()
	-- with extension
	local full_name = vim.fn.expand("%:t")
	return full_name
end

M.filetype = function()
	local filetype = vim.bo.filetype
	return filetype
end

M.parent_path = function()
	local parent_path = vim.fn.expand("%:p:h")
	return parent_path
end

return M
