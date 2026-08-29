return {
	desc = "A framework for interacting with tests within NeoVim",

	{
		"nvim-neotest/neotest",
		opts = { discovery = { enabled = false } },

		cond = function()
			return LazyVim.has_extra("test.core")
		end,
	},

	{
		"nvim-neotest/neotest",
		dependencies = { "haydenmeade/neotest-jest" },

		opts = function(_, opts)
			table.insert(
				opts.adapters,
				require("neotest-jest")({
					-- stylua: ignore
					cwd = function() return vim.fn.getcwd() end,
					jest_test_discovery = true,
					env = { CI = true },
				})
			)
		end,
	},

	{
		"folke/snacks.nvim",
		optional = true,
		opts = require("lazyvimx.util.general").warn_missing_extra("test.core"),
	},
}
