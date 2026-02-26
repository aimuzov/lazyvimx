local M = {}

local defaults = {
	colorscheme = "catppuccin",

	colorscheme_households = {
		catppuccin = {
			{
				"catppuccin-macchiato",
				"catppuccin-frappe",
				"catppuccin-mocha",
				"catppuccin",
				"catppuccin-darkroast",
				"catppuccin-draculatte",
				"catppuccin-espresso",
				"catppuccin-gruvbrew",
				"catppuccin-kanagato",
				"catppuccin-nightbrew",
				"catppuccin-nordiccino",
				"catppuccin-rosetto",
				"catppuccin-solarbica",
			},
			{ "catppuccin-latte" },
		},
		tokyonight = {
			{ "tokyonight-storm", "tokyonight-moon", "tokyonight-night" },
			{ "tokyonight-day" },
		},
	},

	bufferline_groups = {
		-- ["name"] = "regex",
	},
}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
