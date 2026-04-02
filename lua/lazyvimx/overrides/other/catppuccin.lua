local blend = require("lazyvimx.util.general").color_blend

local colors_get = function(flavor)
	return require("catppuccin.palettes").get_palette(flavor)
end

local dashboard_header_animate = function()
	local c = colors_get()
	local colors = { c.blue, c.sky, c.green, c.yellow, c.peach, c.red }
	local limit = require("lazyvimx.util.general").theme_is_dark() and 100 or 20

	for i = 5, limit do
		local timer = vim.loop.new_timer()

		if timer ~= nil then
			timer:start(
				i * 1.06 * 50,
				0,
				vim.schedule_wrap(function()
					for j = 2, 7 do
						vim.api.nvim_set_hl(0, "SnacksDashboardHeader" .. j, { fg = blend(c.base, colors[j - 1], i) })
					end
				end)
			)
		end
	end
end

return {
	"catppuccin/nvim",
	name = "catppuccin",

	dependencies = {
		{
			"aimuzov/catppuccin-barista.nvim",
			import = "catppuccin-barista.beautifier",
			opts = { presets = true },
		},
	},

	optional = true,

	opts = {
		integrations = {
			navic = false,
			treesitter_context = true,
			dap = { enabled = true, enable_ui = true },
		},
	},

	specs = {
		{
			"folke/snacks.nvim",
			dependencies = { "catppuccin/nvim" },
			optional = true,

			opts = function()
				if vim.g.colors_name and vim.g.colors_name:find("catppuccin", 1, true) then
					vim.api.nvim_create_autocmd("User", {
						once = true,
						pattern = "LazyVimStarted",
						callback = dashboard_header_animate,
					})
				end
			end,
		},
	},
}
