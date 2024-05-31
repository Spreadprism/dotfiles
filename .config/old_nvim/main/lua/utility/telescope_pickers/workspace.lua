local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local workspaces = require("workspaces")

local workspace_picker = function(opts)
	opts = opts or {}
	---each workspace is formatted as a { name = "", path = "" } table
	local workspace_list = workspaces.get()
	local workspace_names = {}

	for _, workspace in ipairs(workspace_list) do
		table.insert(workspace_names, workspace.name)
	end
	-- the name of the workspace is the key of the table
	pickers
		.new(opts, {
			prompt_title = "Workspaces",
			finder = finders.new_table({
				results = workspace_names,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local workspace_name = action_state.get_selected_entry()[1]
					workspaces.open(workspace_name)
					vim.defer_fn(function()
						vim.cmd("Dashboard")
					end, 5)
				end)
				return true
			end,
		})
		:find()
end

return workspace_picker
