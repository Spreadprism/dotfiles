local rocks_path = vim.fn.stdpath("data") .. "/rocks.nvim"
if not vim.loop.fs_stat(rocks_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-neorocks/rocks.nvim",
		rocks_path,
	})
end
vim.opt.rtp:prepend(rocks_path)

require("rocks")

local rocks_config = {
	rocks_path = vim.fn.stdpath("data") .. "/rocks",
	luarocks_binary = vim.fn.stdpath("data") .. "/rocks/bin/luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
	vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
	vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

require("rocks.commands").create_commands()
