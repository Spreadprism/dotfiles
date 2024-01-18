return function()
	local stats = require("lazy").stats()
	local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
	local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
	local n_spaces = 3

	local footer = {}

	for i = 1, n_spaces do
		table.insert(footer, "")
	end

	table.insert(footer, "Loaded in " .. ms .. "ms")
	table.insert(footer, "v" .. version)

	return footer
end
