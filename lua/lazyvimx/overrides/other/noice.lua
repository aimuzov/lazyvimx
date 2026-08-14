return {
	{
		"folke/noice.nvim",
		opts = {
			cmdline = {
				-- view = "cmdline_popup",
				-- opts = {
				-- 	win_options = {
				-- 		winhighlight = {
				-- 			Normal = "NormalFloat",
				-- 			FloatBorder = "FloatBorder",
				-- 			FloatTitle = "FloatTitle",
				-- 		},
				-- 	},
				-- },

				view = "cmdline",
				opts = {
					win_options = {
						winblend = 0,
						winhighlight = {
							Normal = "FlashPrompt",
						},
					},
				},
			},

			lsp = {
				documentation = {
					opts = {
						win_options = {
							winhighlight = {
								NormalFloat = "CmpDocFloat",
							},
						},
					},
				},
			},

			format = {
				spinner = {
					name = "toggle4",
				},
			},

			routes = {
				{
					-- Worktree-follow notification → bottom-right "mini" view (same
					-- spot as LSP progress). Emitted via `vim.notify(.., { title })`
					-- in `overrides/snacks/lazygit-follow-worktree.lua`; keep the
					-- title in sync with `notify_title` there.
					view = "mini",
					filter = {
						event = "notify",
						cond = function(message)
							return message.opts and message.opts.title == "lazygit-worktree"
						end,
					},
				},
				{
					view = "mini",
					opts = { skip = true },
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
						},
					},
				},
				{
					view = "notify",
					filter = {
						any = {
							{ find = "Reloading" },
							{ find = "No items, skipping git ignored/status lookups" },
						},
					},
					opts = { skip = true },
				},
				{
					filter = {
						any = {
							{ find = "No information available" },
						},
					},
					opts = { stop = true },
				},
			},
		},
	},

	{
		"folke/noice.nvim",
		opts = function()
			local defaults_orig = require("noice.config").defaults
			local defaults_override = function()
				local defaults = defaults_orig()

				for _, value in pairs(defaults.cmdline.format) do
					value.icon = " " .. value.icon .. " "
				end

				return defaults
			end

			require("noice.config").defaults = defaults_override
		end,
	},
}
