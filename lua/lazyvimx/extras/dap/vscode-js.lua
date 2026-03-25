return {
	desc = "This is a DAP-based JavaScript debugger",

	{
		"mxsdev/nvim-dap-vscode-js",

		cond = function()
			return not vim.g.vscode and LazyVim.has_extra("dap.core")
		end,

		dependencies = {
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && rm -rf out/dist && mv dist out && git restore .",
			},
		},

		opts = {
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-chrome", "pwa-node" },
		},
	},

	{
		"folke/snacks.nvim",
		opts = require("lazyvimx.util.general").warn_missing_extra("dap.core"),
	},

	{
		"mfussenegger/nvim-dap",
		commit = "7ff6936",
		optional = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
		},

		opts = function()
			for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-chrome",
						name = "Launch Chrome to debug client",
						request = "launch",
						url = "http://localhost:8080",
						sourceMaps = true,
						webRoot = "${workspaceFolder}",
						skipFiles = { "**/node_modules/**/*", "**/src/*" },
					},

					{
						type = "pwa-node",
						request = "attach",
						processId = require("dap.utils").pick_process,
						name = "Attach debugger to existing `node --inspect` process",
						sourceMaps = true,
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						cwd = "${workspaceFolder}/src",
						skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
					},

					language == "javascript" and {
						type = "pwa-node",
						request = "launch",
						name = "Launch file in new node process",
						program = "${file}",
						cwd = "${workspaceFolder}",
					} or nil,
				}
			end
		end,
	},
}
