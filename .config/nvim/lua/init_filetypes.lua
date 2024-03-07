vim.filetype.add({
	extension = {
		env = "dotenv",
	},
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		[".env"] = "dotenv",
		["env"] = "dotenv",
	},
	pattern = {
		-- INFO: Match filenames like - ".env.example", ".env.local" and so on
		["%.env%.[%w_.-]+"] = "dotenv",
	},
})

-- INFO: Use bash TS parser for dotenv
vim.treesitter.language.register("bash", "dotenv")
