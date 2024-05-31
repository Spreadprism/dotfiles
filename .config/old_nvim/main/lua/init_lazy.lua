local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- INFO: Add luarocks path for nvim_rocks
local version = _VERSION:match("%d+%.%d+")
package.path = package.path .. ";" .. vim.fn.stdpath("data") .. "/lazy/nvim_rocks/lib/lua/" .. version .. "/?.lua"
package.cpath = package.cpath .. ";" .. vim.fn.stdpath("data") .. "/lazy/nvim_rocks/lib/lua/" .. version .. "/?.so"

require("lazy").setup("plugins", {
	ui = {
		-- border = "rounded",
	},
})
