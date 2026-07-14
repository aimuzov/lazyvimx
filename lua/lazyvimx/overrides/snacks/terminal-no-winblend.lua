-- The global `vim.o.winblend = 5` (boot.lua) makes float windows semi-transparent.
-- Snacks resets winblend to 0 only for transparent themes, so on an opaque
-- theme (catppuccin) the float terminal and lazygit inherit winblend=5 and look washed out.
-- Force winblend to 0 for terminal styles.
return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		styles = {
			terminal = { wo = { winblend = 0 } },
			lazygit = { wo = { winblend = 0 } },
		},
	},
}
