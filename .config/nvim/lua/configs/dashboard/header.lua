local file_utility = require("utility.file_utility")
local env = require("utility.env")

local headers_dir_path = vim.fn.stdpath("data") .. "/headers/"
local headers_session_path = vim.fn.stdpath("data") .. "/headers_session/"

local terminal_width = 80

if not file_utility.exists(headers_dir_path) then
	vim.cmd("silent !mkdir " .. headers_dir_path)
end

-- use vim localtime().getpid() to generate session id
local session_id = vim.fn.localtime().getpid()
