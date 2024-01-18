return function()
	local stats = require("lazy").stats()
	local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
	local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
	return { "Loaded in " .. ms .. "ms", "v" .. version .. "" }
end
