local M = {}

local os_info_path = "/etc/issue"

local os_name = nil

local get_first_word = function(input_string)
	local words = {}
	for word in input_string:gmatch("%S+") do
		table.insert(words, word)
	end
	return words[1]
end

M.os = function()
	if os_name == nil then
		local file = io.open(os_info_path, "r")
		if file == nil then
			os_name = "NA"
		else
			local file_content = file:read("*a")
			file:close()
			os_name = get_first_word(file_content)
		end
	end

	if os_name == "NA" then
		return ""
	else
		return os_name
	end
end

local os_icon = {
	Arch = "󰣇",
	Ubuntu = "",
}

M.icon = function()
	return os_icon[M.os()] or "󰞋"
end

return M
