local neorg_dirman = {}

local dirman = require("neorg.modules.core.dirman.module")

neorg_dirman.get_workspaces = dirman.public.get_workspaces
neorg_dirman.get_workspace_name = dirman.public.get_workspace_name
neorg_dirman.get_workspace = dirman.public.get_workspace
neorg_dirman.get_current_workspace = dirman.public.get_current_workspace
neorg_dirman.set_workspace = dirman.public.set_workspace
neorg_dirman.add_workspace = dirman.public.add_workspace

return neorg_dirman
