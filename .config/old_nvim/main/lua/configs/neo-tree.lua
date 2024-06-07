local fu = require("utility.file_utility")
local env = require("utility.env")
return function()
	-- vim.g.neo_tree_root_folder = "name"
	require("neo-tree").setup({
		close_if_last_window = true,
		use_popups_for_input = true,
		-- popup_border_style = "rounded",
		filesystem = {
			group_empty_dir = true,
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			follow_current_file = {
				enable = true,
			},
			components = {
				name = function(config, node, state)
					local components = require("neo-tree.sources.common.components")
					local name = components.name(config, node, state)
					if node:get_depth() == 1 then
						name.text = env.get("PWD")
						name.text = string.gsub(name.text, "/home/avalon/", "~/")
						name.text = string.gsub(name.text, "/run/media/avalon/", "~/")
					end
					return name
				end,
			},
		},
		use_libuv_file_watcher = true,
		window = {
			mappings = {
				["o"] = function(state)
					local node = state.tree:get_node()
					local path = node.path
					if fu.is_dir(path) then
						if env.get("IN_WSL") == "true" then
							vim.cmd("silent !explorer.exe $(wslpath -w " .. path .. ")")
						else
							vim.cmd("silent !hyprctl dispatch exec nemo " .. path)
						end
					else
						local directory = fu.get_parent_directory(path)
						if env.get("IN_WSL") == "true" then
							vim.cmd("silent !explorer.exe $(wslpath -w " .. directory .. ")")
						else
							vim.cmd("silent !hyprctl dispatch exec nemo" .. directory)
						end
					end
				end,
				["O"] = function(_)
					if env.get("IN_WSL") == "true" then
						vim.cmd("silent !explorer.exe $(wslpath -w $PWD)")
					else
						vim.cmd("silent !hyprctl dispatch exec nemo $PWD")
					end
				end,
				["e"] = function(state)
					local node = state.tree:get_node()
					local path = node.path
					MiniFiles.open(path, false)
				end,
				["a"] = {
					"add",
					-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "relative", -- "none", "relative", "absolute"
					},
				},
			},
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					--auto close
					-- require("neo-tree").close_all()
					vim.cmd("sleep 100m")
					vim.cmd("Neotree close")
				end,
			},
		},
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "󱀶",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "󱇧",
				highlight = "NeoTreeModified",
			},
			name = {
				use_git_status_colors = false,
			},
			git_status = {
				symbols = {
					added = "",
					modified = "",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},
	})
end