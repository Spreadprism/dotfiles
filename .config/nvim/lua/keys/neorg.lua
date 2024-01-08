local M = {}

local neorg_bind = "<leader>n"

M.n = {
	[neorg_bind .. "R"] = {
		function()
			vim.cmd("Neorg workspace Notes")
			vim.cmd("Neorg index")
			vim.cmd("cd ~/Notes")
		end,
		"Root workspace",
	},
	[neorg_bind .. "r"] = {
		"<cmd>Neorg return<CR>",
		"Return",
	},
	[neorg_bind .. "i"] = {
		"<cmd>Neorg index<CR>",
		"Workspace index",
	},
	[neorg_bind .. "w"] = {
		function()
			-- sets_current_path as workspace
			local current_file = vim.fn.expand("%:t")
			if current_file == "index.norg" then
				-- We must set the current directory as our workspace
				local current_directory_name = vim.fn.expand("%:p:h:t")

				-- execute Neorg workspace $current_directory_name
				vim.cmd("Neorg workspace " .. current_directory_name)
				vim.cmd("cd " .. vim.fn.expand("%:p:h"))
			end
		end,
		"Set current index as workspace",
	},
	[neorg_bind .. "td"] = {
		function()
			vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_done")
		end,
		"Toggle task done",
	},
	[neorg_bind .. "tu"] = {
		function()
			vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_undone")
		end,
		"Toggle task undone",
	},
	[neorg_bind .. "th"] = {
		function()
			vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_on_hold")
		end,
		"Toggle task on hold",
	},
	[neorg_bind .. "tp"] = {
		function()
			vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_pending")
		end,
		"Toggle task on pending",
	},
	[neorg_bind .. "ta"] = {
		function()
			vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_ambiguous")
		end,
		"Toggle task ambiguous",
	},
	[neorg_bind .. "tc"] = {
		function()
			vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_cancelled")
		end,
		"Toggle task task_cancelled",
	},
}

return M
