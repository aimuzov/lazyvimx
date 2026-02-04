return {
	desc = "Complete lazyvimx experience with all features, keybindings, and recommended extras notifications",

	{ import = "lazyvimx.extras.core.overrides" },
	{ import = "lazyvimx.extras.core.extras" },
	{ import = "lazyvimx.extras.core.keys" },

	{
		"folke/snacks.nvim",
		opts = function()
			local recommended_extras = {
				"coding.mini-surround",
				"coding.yanky",
				"ui.edgy",
				"ui.treesitter-context",
			}

			local extras_missing_message = {}

			for _, extra_name in pairs(recommended_extras) do
				if not LazyVim.has_extra(extra_name) then
					table.insert(extras_missing_message, "- `" .. extra_name .. "`")
				end
			end

			if next(extras_missing_message) ~= nil then
				table.insert(extras_missing_message, 1, "Missing extras:")
				table.insert(extras_missing_message, "Highly recommend turning them on")
				table.insert(extras_missing_message, "for the best experience")

				Snacks.notify.info(extras_missing_message, { title = "Extras", icon = "[ 󰬟 ]" })
			end
		end,
	},
}
