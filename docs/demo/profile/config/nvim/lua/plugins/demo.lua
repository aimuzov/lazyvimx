-- Импорты экстр для записи. Лежат в lua/plugins не случайно: этот спек
-- boot подключает последним, после lazyvim.plugins — как у настоящих
-- пользователей. Импорт из init.lua падал бы на cond-проверках экстр.

local spec = {
	{ import = "lazyvimx.extras.core.overrides" },
	{ import = "lazyvimx.extras.core.keys" },

	-- Гифки всегда тёмные, какой бы ни была тема системы на машине записи.
	-- Этот спек последний в порядке мержа, поэтому побеждает get_flavor().
	{ "LazyVim/LazyVim", opts = { colorscheme = vim.env.DEMO_COLORSCHEME or "catppuccin-macchiato" } },

	-- luarocks в пустом профиле не собирается (нет системного lua5.1),
	-- а spider без luautf8 для ascii-демо работает так же.
	{ "vhyrro/luarocks.nvim", enabled = false },

	-- Штатная подсветка линии колонки сливается с фоном macchiato,
	-- а Snacks перетирает попытки перекрасить её на лету.
	{ "lukas-reineke/virt-column.nvim", optional = true, opts = { highlight = "Comment" } },

	-- Автодополнение в cmdline на записи вредит: Enter принимает
	-- подсказку blink и портит набранную команду.
	{ "saghen/blink.cmp", optional = true, opts = { cmdline = { enabled = false } } },

	-- Зритель должен видеть, чем вызвано происходящее на экране: плашка
	-- с клавишами включена всегда — через штатную экстру ui.showkeys.
	{ import = "lazyvimx.extras.ui.showkeys" },
	{
		"nvzone/showkeys",
		lazy = false,
		cond = not vim.env.DEMO_HERO,

		opts = function()
			vim.schedule(function()
				require("showkeys").open()
			end)
		end,
	},
}

-- Запись для шапки сайта — фон под заголовком, а не демонстрация UI:
-- всё обрамление буфера убрано, на экране только код.
if vim.env.DEMO_HERO then
	vim.list_extend(spec, {
		{ "nvim-lualine/lualine.nvim", optional = true, cond = false },
		{ "akinsho/bufferline.nvim", optional = true, cond = false },
		{ "nvim-neo-tree/neo-tree.nvim", optional = true, cond = false },

		{
			"LazyVim/LazyVim",
			opts = function()
				vim.o.laststatus = 0
				vim.o.showtabline = 0
			end,
		},
	})
end

for extra in (vim.env.DEMO_EXTRAS or ""):gmatch("[^,]+") do
	table.insert(spec, { import = "lazyvimx.extras." .. vim.trim(extra) })
end

-- На «до»-записях клавиши экстр падать в операторы не должны: c и g
-- начинают менять буфер вместо честного «ничего не произошло».
if (vim.env.DEMO_EXTRAS or "") == "" then
	for _, lhs in ipairs({ "<leader>ct", "gcd", "ct" }) do
		vim.keymap.set("n", lhs, "<nop>")
	end
end

return spec
