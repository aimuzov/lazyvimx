if vim.g.vscode then
	return {}
end

local function colorscheme_update()
	local colorscheme = vim.g.colors_name and vim.g.colors_name:match("^[^-]+") or nil

	vim.cmd.colorscheme(require("lazyvimx.util.general").get_flavor(colorscheme))
end

return {
	"LazyVim/LazyVim",

	opts = function()
		vim.api.nvim_create_autocmd("Signal", {
			pattern = "SIGUSR1",
			desc = "Change colorscheme after system theme changed",
			callback = vim.schedule_wrap(colorscheme_update),
		})
	end,
}
