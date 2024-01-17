-- INFO: required modules to import
--
local module_utility = require("utility.module_utility")
local lspconfig = require("lspconfig")

local vim_diagnostic_opts = {}

local set_autocmd = function()
	-- open floating window when hovering error
	vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Enable completion triggered by "c-x"<c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, opts)

			vim.keymap.set({ "n", "v" }, "<C-n>", vim.lsp.buf.code_action, opts)
			vim.keymap.set({ "n", "v" }, ".", vim.lsp.buf.code_action, opts)
			-- vim.keymap.set("n", "<space>f", function()
			-- 	vim.lsp.buf.format({ async = true })
			-- end, opts)
		end,
	})
end

local define_capabilities = function()
	local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

	-- lsp_capabilities.textDocument.foldingRange = {
	-- 	dynamicRegistration = false,
	-- 	lineFoldingOnly = true,
	-- }
	return lsp_capabilities
end

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr) end

local configure_all_lsp = function()
	local base_capabilities = define_capabilities()
	local lsp_dir = module_utility.BASE_NEOVIM_LUA_PATH .. "/configs/lsp"
	local lsp_to_configure = module_utility.get_modules_in_dir(lsp_dir)
	for _, module in pairs(lsp_to_configure) do
		lspconfig[module].setup(require("configs.lsp." .. module)(on_attach, base_capabilities))
	end
end

local function filter(arr, func)
	-- Filter in place
	-- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
	local new_index = 1
	local size_orig = #arr
	for old_index, v in ipairs(arr) do
		if func(v, old_index) then
			arr[new_index] = v
			new_index = new_index + 1
		end
	end
	for i = new_index, size_orig do
		arr[i] = nil
	end
end

local function filter_diagnostics(diagnostic)
	-- Only filter out Pyright stuff for now
	if diagnostic.source ~= "Pyright" then
		return true
	end

	-- remove any diagnostic messages that end with is not accessed

	if diagnostic.message:find("is not accessed") then
		return false
	end
	return true
end

local function custom_on_publish_diagnostics(_, result, ctx, config)
	filter(result.diagnostics, filter_diagnostics)
	vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

return function()
	vim.diagnostic.config(vim_diagnostic_opts)
	set_autocmd()
	configure_all_lsp()
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})
end
