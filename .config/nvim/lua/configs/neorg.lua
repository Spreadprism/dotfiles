local neorg = {}

local fs = require("utility.file_utility")
local ripgrep = require("utility.ripgrep")
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
	workspaces["quicknote"] = notes_directory .. "/quicknote"

	local index_files = ripgrep.rg("-uuu --files --glob 'index.norg'", "~/Notes")

	if index_files ~= nil then
		for _, index_file in pairs(index_files) do
			workspaces[get_workspace_name(index_file)] = fs.get_parent_directory(index_file)
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
					workspaces = get_workspaces(),
					default_workspace = get_workspace_name(notes_directory),
				},
			},
			["core.ui"] = {},
			["core.ui.calendar"] = {},
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
