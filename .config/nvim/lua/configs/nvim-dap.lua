local module_utility = require("utility.module_utility")

local load_dap_configurations = function()
	local dap_configs = module_utility.BASE_NEOVIM_LUA_PATH .. "/configs/dap_configurations"
	local dap_to_configure = module_utility.get_modules_in_dir(dap_configs)
	local dap = require("dap")
	for _, module in pairs(dap_to_configure) do
		dap.configurations[module] = require("configs.dap_configurations." .. module)
	end
end

local load_dap_adapters = function()
	local dap_adapters_dir = module_utility.BASE_NEOVIM_LUA_PATH .. "/configs/dap_adapters"
	local dap_adapters = module_utility.get_modules_in_dir(dap_adapters_dir)
	local dap = require("dap")
	for _, module in pairs(dap_adapters) do
		dap.adapters[module] = require("configs.dap_adapters." .. module)
	end
end

return function()
	-- INFO: Setting DAP icons
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "󰯲", texthl = "ErrorMsg", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

	vim.cmd("highlight DapStoppedSign guifg=#87D285")
	vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedSign", linehl = "DapStoppedSign", numhl = "" })

	load_dap_adapters()
	load_dap_configurations()

	require("dap.ext.vscode").load_launchjs(nil, {
		codelldb = { "rust", "c" },
	})
end
