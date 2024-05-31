local cmp = require("cmp")
local select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_kinds = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
	Copilot = "  ",
}

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "git" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			if entry.source.name == "path" then
				item.kind = cmp_kinds.Folder
				item.menu = "(path)"
			else
				local kind = cmp_kinds[item.kind] or ""
				if item.kind ~= "Copilot" then
					item.menu = "(" .. item.kind .. ")"
				end
				item.kind = kind
			end
			return item
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
