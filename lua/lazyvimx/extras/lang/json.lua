return {
	"nvim-treesitter/nvim-treesitter",
	desc = "JSONC support via json treesitter parser",

	opts = function(_, opts)
		opts.ensure_installed = opts.ensure_installed or {}

		vim.list_extend(opts.ensure_installed, { "json" })
		vim.treesitter.language.register("json", "jsonc")
	end,
}
