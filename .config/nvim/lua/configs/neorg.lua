local neorg = {}

local fs = require("utility.file_utility")
local env = require("utility.env")

local notes_directory = env.get("HOME") .. "/Notes"

local get_workspace_name = function(path)
	-- get directory name of path
	local directory = ""

	if fs.is_dir(path) then
		directory = path
	else
		directory = fs.get_parent_directory(path)
	end
	-- extract directory name
	local name = string.match(directory, ".*/(.*)")
	return name
end

local get_workspaces = function()
	local workspaces = {}

	workspaces[get_workspace_name(notes_directory)] = notes_directory
	workspaces["quicknote"] = env.get("HOME") .. "/quicknote"

	local pattern = "*/index.norg"
	local index_files = fs.get_files(env.get("HOME") .. "/Notes", pattern)
	if index_files ~= nil then
		for _, index_file in pairs(index_files) do
			local actual_path = fs.get_parent_directory(notes_directory .. "/" .. index_file)
			workspaces[get_workspace_name(actual_path)] = actual_path
		end
	end

	return workspaces
end

neorg.setup = function()
	require("neorg").setup({
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.completion"] = {
				config = {
					engine = "nvim-cmp",
				},
			}, -- Loads default behaviour
			["core.concealer"] = {
				config = {
					icon_preset = "diamond",
				},
			}, -- Adds pretty icons to your documents
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					-- workspaces = {
					-- 	Notes = "~/Notes",
					-- 	personal = "~/Notes/personal",
					-- 	school = "~/Notes/school",
					-- 	-- classes
					-- 	MTI840 = "~/Notes/school/MTI840",
					-- 	MGR850 = "~/Notes/school/MGR850",
					-- },
					workspaces = get_workspaces(),
					default_workspace = "Notes",
				},
			},
		},
	})
end
neorg.config = function()
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function()
			-- If filetype is neorg, set the conceallevel to 3 else 0
			if vim.bo.filetype == "norg" then
				vim.wo.conceallevel = 3
			else
				vim.wo.conceallevel = 0
			end
		end,
	})
	neorg.setup()
end

return neorg
