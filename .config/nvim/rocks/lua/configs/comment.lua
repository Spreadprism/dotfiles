local keybind = require("utility.keybind_manager").Keybind.new
require("Comment").setup({})
keybind("v", "/", "gcgv", "toggle comment")
