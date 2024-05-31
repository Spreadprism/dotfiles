return {
	{
		-- use nvim-dap-vscode-js's pwa-node debug adapter
		type = "(NVIM-CONFIG) pwa-node",
		-- launch a new process to attach the debugger to
		request = "launch",
		-- name of the debug action you have to select for this config
		name = "Launch current file in new node process",
		program = "${file}",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
	},
	{
		-- use nvim-dap-vscode-js's pwa-node debug adapter
		type = "(NVIM-CONFIG) pwa-node",
		-- attach to an already running node process with --inspect flag
		-- default port: 9222
		request = "attach",
		-- allows us to pick the process using a picker
		processId = require("dap.utils").pick_process,
		-- name of the debug action
		name = "Attach debugger to existing `node --inspect` process",
		-- for compiled languages like TypeScript or Svelte.js
		sourceMaps = true,
		-- resolve source maps in nested locations while ignoring node_modules
		resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
		-- path to src in vite based projects (and most other projects as well)
		cwd = "${workspaceFolder}/src",
		-- we don't want to debug code inside node_modules, so skip it!
		skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
	},
	{
		name = "(NVIM-CONFIG) Launch chrome debugger (NEXT)",
		type = "pwa-chrome",
		request = "launch",
		url = "http://localhost:3000",
		-- skip files from vite's hmr
		skipFiles = { "**/node_modules/**/*", "**/src/*" },
		resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
		webRoot = "${workspaceFolder}",
		sourceMaps = true,
		port = "9222",
		console = "integratedTerminal",
	},
	{
		name = "(NVIM-CONFIG) Launch chrome debugger (vite)",
		type = "pwa-chrome",
		request = "launch",
		url = "http://localhost:5173",
		-- skip files from vite's hmr
		skipFiles = { "**/node_modules/**/*", "**/src/*" },
		resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
		webRoot = "${workspaceFolder}",
		sourceMaps = true,
		port = "9222",
		console = "integratedTerminal",
	},
}
