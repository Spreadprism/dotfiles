return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup({
				adapters = {
					-- INFO: Golang
					-- require("rustaceanvim.neotest"),
					require("neotest-go")({
						experimental = {
							test_table = true,
						},
						args = { "-count=1", "-timeout=60s" },
					}),
					-- INFO: Javascript
					require("neotest-vitest"),
					-- INFO: Python
					require("neotest-python")({
						python = require("utility.python_env_manager").get_python_path(),
						runner = "pytest",
						args = { "--log-level", "DEBUG" },
						dap = { justMyCode = true },
					}),
					-- INFO: Rust
					require("neotest-rust")({
						args = { "--no-capture" },
						dap_adapter = "codelldb",
					}),
				},
			})
		end,
	},
}
