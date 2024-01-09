local M = {}

local neorg_bind = "<leader>n"
local dirman = require("neorg.modules.core.dirman.module")

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
				local current_directory_name = vim.fn.expand("%:p:h:t")

				local current_workspace = require("utility.neorg_dirman").get_current_workspace()[1]
				if current_workspace ~= current_directory_name then
					vim.cmd("Neorg workspace " .. current_directory_name)
				end
				-- We must set the current directory as our workspace
				vim.cmd("cd " .. vim.fn.expand("%:p:h"))
				require("utility.workspace_utilities").on_open()
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
	[neorg_bind .. "nn"] = {
		function()
			vim.cmd("Neorg keybind all core.dirman.new.note")
		end,
		"New note",
	},
	[neorg_bind .. "nw"] = {
		function()
			local add_workspace = dirman.public.add_workspace

			local current_neorg_workspace = vim.fn.expand("%:p:h")
			-- extract directory name
			local new_neorg_workspace = vim.fn.input("New workspace: ")
			os.execute("mkdir -p " .. new_neorg_workspace)
			local new_workspace_path = current_neorg_workspace .. "/" .. new_neorg_workspace
			add_workspace(new_neorg_workspace, new_workspace_path)
			vim.cmd("Neorg workspace " .. new_neorg_workspace)
			vim.cmd("w")
			vim.cmd("cd " .. vim.fn.expand("%:p:h"))
			-- don't need to write any message, dirman already does it
		end,
		"New workspace",
	},
	["snw"] = {
		function()
			require("utility.telescope_pickers.neorg_workspace")()
		end,
		"Search workspace",
	},
}

return M
