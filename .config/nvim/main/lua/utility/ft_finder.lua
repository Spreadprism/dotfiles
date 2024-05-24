local finder = {}

local async = require("plenary.async")
local fs = require("utility.file_utility")

local get_all_fts = function() 
  local root = vim.fn.getcwd()

  local files = fs.get_all_files(root, { depth = 1 })
end

finder.refresh = function() end

return finder
