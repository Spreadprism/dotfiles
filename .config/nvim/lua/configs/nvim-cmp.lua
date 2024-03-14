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

local format = function(entry, item)
	if entry.source.name == "path" then
		item.kind = cmp_kinds.Folder
		item.menu = "(path)"
	elseif entry.source.name == "luasnip" then
		item.kind = " "
		item.menu = "(LuaSnip)"
	elseif entry.source.name == "crates" then
		item.kind = "  "
		item.menu = "(crates)"
	elseif entry.source.name == "py-requirements" then
		item.kind = "  "
		item.menu = "(pip)"
	elseif entry.source.name == "vim-dadbod-completion" then
		-- item kind should be a db icon from nerdfont
		item.kind = " "
	else
		local kind = (cmp_kinds[item.kind] or "")
		if item.kind ~= "Copilot" then
			item.menu = "(" .. item.kind .. ")"
		end
		item.kind = kind
	end
	return item
end

local formatting = {
	fields = { "kind", "abbr", "menu" },
	format = format,
}

return function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local select_opts = { behavior = cmp.SelectBehavior.Select }

	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#51afef" })
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "otter" },
			{ name = "crates" },
			{ name = "py-requirements" },
		}),
		window = {
			documentation = cmp.config.window.bordered(),
		},
		formatting = formatting,
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item(select_opts),
			["<Down>"] = cmp.mapping.select_next_item(select_opts),

			["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
			["<C-n>"] = cmp.mapping.select_next_item(select_opts),

			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),

			["<C-e>"] = cmp.mapping.abort(),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			["<C-f>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<C-b>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<Tab>"] = cmp.mapping(function(fallback)
				local col = vim.fn.col(".") - 1

				if cmp.visible() then
					cmp.select_next_item(select_opts)
				elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
					fallback()
				else
					cmp.complete()
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

	-- cmp.event:on("menu_opened", function()
	-- 	vim.b.copilot_suggestion_hidden = true
	-- end)
	--
	-- cmp.event:on("menu_closed", function()
	-- 	vim.b.copilot_suggestion_hidden = false
	-- end)
end
