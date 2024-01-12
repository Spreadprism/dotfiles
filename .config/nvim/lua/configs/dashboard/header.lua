local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

-- INFO: need to install figlet-cli
-- npm install -g figlet-cli
-- make_it_rainbow
-- lolcat
local handle = io.popen("figlet -f 'ANSI Shadow' " .. cwd_name)

if handle == nil then
	return {}
end

local logo = handle:read("*a")
handle:close()

logo = string.rep("\n", 8) .. logo .. "\n\n"

return vim.split(logo, "\n")
