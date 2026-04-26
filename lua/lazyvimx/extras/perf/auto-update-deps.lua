return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },

	opts = function(_, opts)
		local list = {}
		local seen = {}

		local ok, registry = pcall(require, "mason-registry")
		if ok then
			for _, pkg in ipairs(registry.get_installed_packages()) do
				if not seen[pkg.name] then
					seen[pkg.name] = true
					list[#list + 1] = pkg.name
				end
			end
		end

		opts.ensure_installed = list
		opts.auto_update = true
	end,
}
