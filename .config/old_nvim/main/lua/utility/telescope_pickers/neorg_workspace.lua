local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local neorg_workspace = function(opts)
	opts = opts or {}
	-- the name of the workspace is the key of the table
	pickers
		.new(opts, {
			prompt_title = "Neorg workspaces",
			finder = finders.new_table({
				results = vim.tbl_keys(require("utility.neorg_dirman").get_workspaces()),
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local workspace_name = action_state.get_selected_entry()[1]
					-- execute Neorg workspace $current_directory_name
					vim.cmd("Neorg workspace " .. workspace_name)
					vim.cmd("Neorg index")
					vim.cmd("cd " .. vim.fn.expand("%:p:h"))
					require("utility.workspace_utilities").on_open()
				end)
				return true
			end,
		})
		:find()
end

return neorg_workspace
