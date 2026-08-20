-- Разводит prettier и oxfmt по проектам, чтобы не дрались за один буфер:
-- oxfmt — только где лежит oxc-конфиг, prettier — только где его нет.
-- Иначе extra `lang.typescript.oxc` гоняет oxfmt во всех JS/TS-проектах.

local oxc_markers = {
	".oxfmtrc.json",
	".oxfmtrc.jsonc",
	"oxfmt.config.ts",
	".oxlintrc.json",
	".oxlintrc.jsonc",
	"oxlint.config.ts",
}

local function has_oxc(ctx)
	return vim.fs.root(ctx.filename, oxc_markers) ~= nil
end

local function with_condition(formatter, extra_condition)
	local prev = formatter and formatter.condition

	return vim.tbl_deep_extend("force", formatter or {}, {
		condition = function(self, ctx)
			return (prev == nil or prev(self, ctx)) and extra_condition(ctx)
		end,
	})
end

return {
	"stevearc/conform.nvim",
	optional = true,

	opts = function(_, opts)
		if not LazyVim.has_extra("lang.typescript.oxc") then
			return
		end

		opts.formatters = opts.formatters or {}
		opts.formatters.oxfmt = with_condition(opts.formatters.oxfmt, has_oxc)

		if LazyVim.has_extra("formatting.prettier") then
			-- condition у prettier уже проверяет парсер, а модуль с проверкой
			-- апстрим наружу не отдаёт — поэтому оборачиваем, а не заменяем.
			opts.formatters.prettier = with_condition(opts.formatters.prettier, function(ctx)
				return not has_oxc(ctx)
			end)
		end
	end,
}
