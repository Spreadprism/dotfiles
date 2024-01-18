-- local cwd_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--
-- -- INFO: need to install figlet-cli
-- -- npm install -g figlet-cli
-- -- make_it_rainbow
-- -- lolcat
--
-- -- restrict cwd_name to 9 characters
-- if cwd_name ~= nil and string.len(cwd_name) > 9 then
-- 	cwd_name = string.sub(cwd_name, 1, 9)
-- 	cwd_name = cwd_name .. "..."
-- end
--
-- local handle = io.popen("figlet -f 'ANSI Shadow' " .. cwd_name)
--
-- if handle == nil then
-- 	return {}
-- end
--
-- local logo = handle:read("*a")
-- handle:close()

local logo = [[
]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

return vim.split(logo, "\n")
