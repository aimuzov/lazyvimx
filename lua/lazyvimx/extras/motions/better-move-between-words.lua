return {
	{
		"chrisgrieser/nvim-spider",
		desc = "Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation",
		dependencies = { "vhyrro/luarocks.nvim" },
		vscode = true,
		config = true,
	},

	-- luautf8 обязателен: без него nvim-spider не видит подслова в кириллице.
	-- Сборка luarocks.nvim требует lua или luajit в PATH (brew install luajit),
	-- иначе билд падает с «module dkjson not found» — см. Prerequisites в README
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		vscode = true,
		opts = { rocks = { "luautf8" } },
	},
}
