local utils = require("new-file-template.utils")
local templates_path = require("utility.module_utility").BASE_NEOVIM_LUA_PATH .. "/templates"

local function base_template(relative_path, filename)
	return [[
{
  |cursor|
}]]
end

local function vscode_task(relative_path, filename)
	return require("templates.vscode_tasks.base")
end

local function vscode_launch(relative_path, filename)
	return require("templates.vscode_launch.base")
end
--- @param opts table
---   A table containing the following fields:
---   - `full_path` (string): The full path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `relative_path` (string): The relative path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `filename` (string): The filename of the new file, e.g., "init.lua".
return function(opts)
	local template = {
		{ pattern = ".*/launch.json", content = vscode_launch },
		{ pattern = ".*/tasks.json", content = vscode_task },
		{ pattern = ".*", content = base_template },
	}

	return utils.find_entry(template, opts)
end
