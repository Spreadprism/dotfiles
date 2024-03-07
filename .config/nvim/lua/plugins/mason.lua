local language_servers = {
	-- "lua_ls",
	-- "tsserver",
	-- "gopls",
	-- "pyright",
}

local daps_plugins = {
	-- "java-debug-adapter",
}

local external_tools = {
	-- "debugpy",
	-- "black",
	-- "prettier",
	-- "js-debug-adapter",
}

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		build = ":MasonUpdate",
		init = function()
			local pylsp = require("mason-registry").get_package("python-lsp-server")
			pylsp:on("install:success", function()
				local function mason_package_path(package)
					local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
					return path
				end

				local path = mason_package_path("python-lsp-server")
				local command = path .. "/venv/bin/pip"
				local args = {
					"install",
					"-U",
					"pylsp-rope",
				}

				require("plenary.job")
					:new({
						command = command,
						args = args,
						cwd = path,
					})
					:start()
			end)
		end,
		config = function()
			require("mason").setup({
				ui = {
					-- border = "rounded",
					width = 0.8,
					height = 0.8,
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-tool-installer").setup({ ensure_installed = external_tools })
		end,
	},
	-- {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = "williamboman/mason.nvim",
	-- 	config = function()
	-- 		require("mason-lspconfig").setup({ ensure_installed = language_servers })
	-- 	end,
	-- },
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = daps_plugins,
				automatic_installation = true,
			})
		end,
	},
}
