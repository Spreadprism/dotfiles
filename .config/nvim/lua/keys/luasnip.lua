local M = {}

M.i = {
	["<M-k>"] = {
		function()
			local ls = require("luasnip")
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end,
	},
	["<M-j>"] = {
		function()
			local ls = require("luasnip")
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end,
	},
	["<M-l>"] = {
		function()
			local ls = require("luasnip")
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end,
	},
}

M.s = M.i
return M
