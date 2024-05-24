local get_program = function()
	return vim.fn.input("program: ", vim.fn.getcwd() .. "/" .. vim.fn.expand("%f"), "file")
end
local get_args = function()
	return vim.split(vim.fn.input("args: ", "", "file"), " ")
end

return {
	{
		type = "codelldb",
		request = "launch",
		cwd = "${workspaceFolder}",
		terminal = "integrated",
		console = "integratedTerminal",
		stopOnEntry = false,
		program = get_program,
		args = get_args,
	},
}
