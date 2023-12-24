local env = require("utility.env")

local omnisharp_env = "OMNISHARP_PATH"
env.set(omnisharp_env, env.get("HOME") .. "/.local/share/nvim/mason/bin/omnisharp")

return function(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { env.get(omnisharp_env) },
	}
end
