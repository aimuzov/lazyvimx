# Справочник API

> [!TIP]
> **🇬🇧 English version:** [API.md](API.md)

Полная документация API для утилитных функций и модулей lazyvimx.

## Содержание

- [Основной модуль](#основной-модуль)
- [Общие утилиты](#общие-утилиты)
- [Утилиты компоновки](#утилиты-компоновки)
- [Функции загрузки](#функции-загрузки)
- [Утилиты плагинов](#утилиты-плагинов)

---

## Основной модуль

**Модуль:** `lazyvimx`
**Расположение:** `lua/lazyvimx/init.lua`

### `setup(opts)`

Инициализирует lazyvimx с пользовательской конфигурацией.

**Сигнатура:**

```lua
function M.setup(opts?: table)
```

**Параметры:**

- `opts` (table, optional) - Параметры конфигурации

**Схема конфигурации:**

```lua
{
	colorscheme?: string,                    -- Base colorscheme name
	colorscheme_flavors?: {
		[string]: { string, string }           -- { dark_variant, light_variant }
	},
	bufferline_groups?: {
		[string]: string                       -- { group_name: pattern }
	}
}
```

**Конфигурация по умолчанию:**

```lua
{
	colorscheme = "catppuccin",
	colorscheme_flavors = {
		catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
		tokyonight = { "tokyonight-storm", "tokyonight-day" },
	},
	bufferline_groups = {},
}
```

**Использование:**

```lua
require("lazyvimx").setup({
	colorscheme = "tokyonight",
	bufferline_groups = {
		["React"] = "%.tsx$",
	},
})
```

**Возвращает:** None

**Побочные эффекты:**

- Устанавливает `M.config` с объединенной конфигурацией
- Доступна глобально как `require("lazyvimx").config`

### `config`

Доступ к текущей конфигурации.

**Тип:** `table`

**Использование:**

```lua
local config = require("lazyvimx").config
print(config.colorscheme)  -- "catppuccin"
```

---

## Общие утилиты

**Модуль:** `lazyvimx.util.general`
**Расположение:** `lua/lazyvimx/util/general.lua`

### `color_blend(color_first, color_second, percentage)`

Смешивает два hex-цвета по проценту.

**Сигнатура:**

```lua
function M.color_blend(
	color_first: string,
	color_second: string,
	percentage: number
): string
```

**Параметры:**

- `color_first` (string) - Первый hex-цвет (например, "#FF0000")
- `color_second` (string) - Второй hex-цвет (например, "#0000FF")
- `percentage` (number) - Процент смешивания (0-100)

**Возвращает:** (string) - Смешанный hex-цвет

**Пример:**

```lua
local util = require("lazyvimx.util.general")

-- Blend red with blue at 50%
local purple = util.color_blend("#FF0000", "#0000FF", 50)
-- Returns: "#7F007F"

-- Blend with 25% of second color
local light_red = util.color_blend("#FF0000", "#FFFFFF", 25)
-- Returns: "#FF3F3F"
```

**Варианты использования:**

- Настройка темы
- Динамическая генерация подсветки
- Интерполяция цветов

**Примечание по реализации:**
Использует цветовое пространство RGB для смешивания.

### `popen_get_result(cmd)`

Выполняет команду оболочки и возвращает обрезанный вывод.

**Сигнатура:**

```lua
function M.popen_get_result(cmd: string): string
```

**Параметры:**

- `cmd` (string) - Команда оболочки для выполнения

**Возвращает:** (string) - Вывод команды (обрезанный, без переводов строк)

**Пример:**

```lua
local util = require("lazyvimx.util.general")

local result = util.popen_get_result("echo hello")
-- Returns: "hello"

local theme = util.popen_get_result("defaults read -g AppleInterfaceStyle 2>&1")
-- Returns: "Dark" or ""
```

**Обработка ошибок:**
Возвращает пустую строку, если команда не выполнена или дескриптор nil.

### `theme_is_dark()`

Проверяет, включен ли темный режим в macOS.

**Сигнатура:**

```lua
function M.theme_is_dark(): boolean
```

**Возвращает:** (boolean) - `true` если темный режим, `false` в противном случае

**Пример:**

```lua
local util = require("lazyvimx.util.general")

if util.theme_is_dark() then
	print("Dark mode active")
else
	print("Light mode active")
end
```

**Платформа:** только macOS

**Реализация:**

```lua
defaults read -g AppleInterfaceStyle
-- Returns "Dark" in dark mode
-- Returns error in light mode
```

### `get_dotfiles_path()`

Получает путь к исходным dotfiles из окружения.

**Сигнатура:**

```lua
function M.get_dotfiles_path(): string
```

**Возвращает:** (string) - Путь к dotfiles или пустая строка

**Пример:**

```lua
local util = require("lazyvimx.util.general")

local path = util.get_dotfiles_path()
if path ~= "" then
	print("Dotfiles at:", path)
end
```

**Переменная окружения:** `DOTFILES_SRC_PATH`

**Использование в коде:**

```lua
local dotfiles = util.get_dotfiles_path()
if dotfiles ~= "" then
	local lazy_lock = vim.fn.stdpath("config") .. "/lazy-lock.json"
	vim.fn.system(string.format("chezmoi add %s", lazy_lock))
end
```

### `get_flavor(colorscheme?)`

Получает подходящий вариант цветовой схемы на основе системной темы.

**Сигнатура:**

```lua
function M.get_flavor(colorscheme?: string): string
```

**Параметры:**

- `colorscheme` (string, optional) - Название цветовой схемы (по умолчанию значение из конфигурации)

**Возвращает:** (string) - Название варианта цветовой схемы

**Пример:**

```lua
local util = require("lazyvimx.util.general")

-- In dark mode:
local flavor = util.get_flavor("catppuccin")
-- Returns: "catppuccin-macchiato"

-- In light mode:
local flavor = util.get_flavor("catppuccin")
-- Returns: "catppuccin-latte"

-- Use configured colorscheme:
local flavor = util.get_flavor()
```

**Логика:**

1. Проверяет системную тему с помощью `theme_is_dark()`
2. Выбирает индекс 1 (темная) или 2 (светлая)
3. Возвращает вариант из `config.colorscheme_flavors`

### `has_extra(extra)`

Проверяет, загружен ли конкретный extra.

**Сигнатура:**

```lua
function M.has_extra(extra: string): boolean
```

**Параметры:**

- `extra` (string) - Название extra (например, "ui.winbar")

**Возвращает:** (boolean) - `true` если extra загружен

**Пример:**

```lua
local util = require("lazyvimx.util.general")

if util.has_extra("ui.winbar") then
	print("Winbar is enabled")
end

-- Conditional configuration:
if util.has_extra("ui.edgy") then
	-- Configure edgy integration
end
```

**Проверяет:**

- Загруженные модули Lazy.nvim
- JSON-данные extras LazyVim

### `warn_missing_extra(extra_name)`

Создает callback, который предупреждает об отсутствии extra.

**Сигнатура:**

```lua
function M.warn_missing_extra(extra_name: string): function
```

**Параметры:**

- `extra_name` (string) - Название extra для проверки

**Возвращает:** (function) - Callback-функция

**Пример:**

```lua
local util = require("lazyvimx.util.general")

return {
	{
		"plugin/name",
		init = util.warn_missing_extra("ui.diff-view"),
	}
}

-- Shows notification if ui.diff-view is not loaded:
-- "Missing extra: `ui.diff-view`"
```

**Вариант использования:**
Предупредить пользователей о необходимых extras для дополнительных функций.

---

## Утилиты компоновки

**Модуль:** `lazyvimx.util.layout`
**Расположение:** `lua/lazyvimx/util/layout.lua`

Управляет согласованным размером боковых панелей и панелей.

### Конфигурация

**Внутреннее состояние:**

```lua
local size = {
	left = 40,
	right = 40,
	top = 10,
	bottom = 10,
}

M.step = 3  -- Resize step size
```

### `get_size(pos)`

Получает текущий размер для позиции.

**Сигнатура:**

```lua
function M.get_size(pos: string): number
```

**Параметры:**

- `pos` (string) - Позиция: "left", "right", "top", или "bottom"

**Возвращает:** (number) - Значение размера

**Пример:**

```lua
local layout = require("lazyvimx.util.layout")

local left_width = layout.get_size("left")
-- Returns: 40

local bottom_height = layout.get_size("bottom")
-- Returns: 10
```

### `get_size_create(pos)`

Создает функцию, которая возвращает размер для позиции.

**Сигнатура:**

```lua
function M.get_size_create(pos: string): function
```

**Параметры:**

- `pos` (string) - Позиция: "left", "right", "top", или "bottom"

**Возвращает:** (function) - Функция, возвращающая размер

**Пример:**

```lua
local layout = require("lazyvimx.util.layout")

-- Used in plugin configuration:
{
	"plugin/name",
	opts = {
		width = layout.get_size_create("left"),
	}
}

-- Equivalent to:
{
	opts = {
		width = function() return 40 end,
	}
}
```

**Вариант использования:**
Edgy.nvim и другие плагины, которые принимают функции размера.

### `increase_create(dir)`

Создает функцию, которая увеличивает размер окна.

**Сигнатура:**

```lua
function M.increase_create(dir: string): function
```

**Параметры:**

- `dir` (string) - Направление: "width" или "height"

**Возвращает:** (function) - Функция, которая увеличивает размер

**Пример:**

```lua
local layout = require("lazyvimx.util.layout")

-- Used in keybinding:
vim.keymap.set("n", "<C-w>+", function()
	local win = require("edgy").get_win()
	if win then
		layout.increase_create("height")(win)
	end
end)
```

**Поведение:**

- Увеличивает размер на `M.step` (по умолчанию: 3)
- Обновляет внутреннее состояние
- Изменяет размер окна

### `decrease_create(dir)`

Создает функцию, которая уменьшает размер окна.

**Сигнатура:**

```lua
function M.decrease_create(dir: string): function
```

**Параметры:**

- `dir` (string) - Направление: "width" или "height"

**Возвращает:** (function) - Функция, которая уменьшает размер

**Пример:**

```lua
local layout = require("lazyvimx.util.layout")

-- Used in keybinding:
vim.keymap.set("n", "<C-w>-", function()
	local win = require("edgy").get_win()
	if win then
		layout.decrease_create("height")(win)
	end
end)
```

**Поведение:**

- Уменьшает размер на `M.step` (по умолчанию: 3)
- Обновляет внутреннее состояние
- Изменяет размер окна

### Использование в конфигурации Edgy

```lua
{
	"folke/edgy.nvim",
	opts = function()
		local layout = require("lazyvimx.util.layout")

		return {
			left = {
				size = layout.get_size_create("left"),
			},
			bottom = {
				size = layout.get_size_create("bottom"),
			},
			keys = {
				["<c-Left>"] = function(win) layout.decrease_create("width")(win) end,
				["<c-Right>"] = function(win) layout.increase_create("width")(win) end,
				["<c-Up>"] = function(win) layout.increase_create("height")(win) end,
				["<c-Down>"] = function(win) layout.decrease_create("height")(win) end,
			},
		}
	end,
}
```

---

## Функции загрузки

**Модуль:** Boot system
**Расположение:** `lua/lazyvimx/boot.lua`

Внутренние функции, используемые во время начальной загрузки. Не предназначены для прямого использования.

### `set_global()`

Устанавливает глобальные переменные для конфигурации LazyVim.

**Внутренняя функция**

**Устанавливает:**

```lua
vim.g.lazyvim_check_order = false
vim.g.xtras_prios = {}
vim.g.lazyvim_explorer = "neo-tree"
```

### `vimopts_set_values()`

Настраивает параметры Vim.

**Внутренняя функция**

См. [CONFIGURATION.md#vim-options](./CONFIGURATION.md#vim-options) для подробностей.

### `insert_extras()`

Регистрирует extras lazyvimx в UI extras LazyVim.

**Внутренняя функция**

**Добавляет источник:**

```lua
{
	name = "[ 󰬟 ]",
	desc = "Some recipes (extras) for enhance lazyvim",
	module = "lazyvimx.extras",
}
```

### `set_colorscheme(_, opts)`

Устанавливает цветовую схему на основе системной темы.

**Внутренняя функция**

**Использование:**

```lua
opts.colorscheme = require("lazyvimx.util.general").get_flavor()
```

### `has_plugins_dir()`

Проверяет, есть ли у пользователя пользовательская директория плагинов.

**Внутренняя функция**

**Возвращает:** (boolean) - `true` если существует `lua/plugins/*.lua`

---

## Утилиты плагинов

### Пользовательские группы для Bufferline

**Функция:** `custom_groups_create()`
**Расположение:** `lua/lazyvimx/overrides/bufferline/add-groups.lua`

Создает пользовательские группы буферов из конфигурации.

**Возвращает:** (table) - Конфигурация групп Bufferline

**Использование в конфигурации:**

```lua
require("lazyvimx").setup({
	bufferline_groups = {
		["React"] = "%.tsx$",
	},
})
```

**Сгенерированные группы:**

```lua
{
	name = "React",
	matcher = function(buf)
		return buf.path:match("%.tsx$")
	end,
}
```

---

## Определения типов

Для справки, вот основные формы типов:

### Config Type

```lua
---@class lazyvimxConfig
---@field colorscheme string
---@field colorscheme_flavors table<string, string[]>
---@field bufferline_groups table<string, string>
```

### Layout Size Type

```lua
---@alias LayoutPosition "left"|"right"|"top"|"bottom"
---@alias LayoutDirection "width"|"height"
```

---

## Примеры использования

### Полная настройка темы

```lua
-- lua/config/lazyvimx.lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",
	colorscheme_flavors = {
		catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
	},
})

-- lua/plugins/theme.lua
local util = require("lazyvimx.util.general")

return {
	{
		"catppuccin/nvim",
		opts = {
			custom_highlights = function(colors)
				-- Use color blending
				local subtle = util.color_blend(colors.base, colors.overlay0, 30)
				return {
					Comment = { fg = subtle },
				}
			end,
		},
	},
}
```

### Условная функция

```lua
-- lua/plugins/conditional.lua
local util = require("lazyvimx.util.general")

return {
	{
		"plugin/name",
		cond = function()
			return util.has_extra("ui.winbar")
		end,
		opts = {
			-- Configuration
		},
	},
}
```

### Интеграция компоновки

```lua
-- lua/plugins/sidebar.lua
local layout = require("lazyvimx.util.layout")

return {
	{
		"sidebar/plugin",
		opts = {
			width = layout.get_size_create("left"),
			resize_keys = {
				["<C-w>>"] = layout.increase_create("width"),
				["<C-w><"] = layout.decrease_create("width"),
			},
		},
	},
}
```

### Интеграция Dotfiles

```lua
-- lua/plugins/chezmoi.lua
local util = require("lazyvimx.util.general")

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*/nvim/lua/**/*.lua",
	callback = function()
		local dotfiles = util.get_dotfiles_path()
		if dotfiles ~= "" then
			local file = vim.fn.expand("%:p")
			vim.fn.system(string.format("chezmoi add %s", file))
			print("Added to chezmoi:", vim.fn.fnamemodify(file, ":t"))
		end
	end,
})
```

---

## Лучшие практики

### 1. Проверяйте доступность Extra

Всегда проверяйте, загружены ли extras, перед использованием их функций:

```lua
local util = require("lazyvimx.util.general")

if util.has_extra("ui.edgy") then
	-- Configure edgy integration
end
```

### 2. Используйте утилиты компоновки для согласованности

Используйте утилиты компоновки вместо жестко закодированных размеров:

```lua
-- ❌ Don't
opts = { width = 40 }

-- ✅ Do
local layout = require("lazyvimx.util.layout")
opts = { width = layout.get_size_create("left") }
```

### 3. Безопасный доступ к конфигурации

Проверяйте существование конфигурации перед доступом:

```lua
local ok, config = pcall(function()
	return require("lazyvimx").config
end)

if ok then
	-- Use config
end
```

### 4. Используйте смешивание цветов для тем

Создавайте гармоничные цвета с помощью смешивания:

```lua
local util = require("lazyvimx.util.general")

-- Create subtle variant
local subtle_bg = util.color_blend(base_bg, overlay, 15)

-- Create highlight variant
local highlight_fg = util.color_blend(base_fg, accent, 30)
```

---

## Сводка API

| Модуль         | Функции                                                                                   | Назначение             |
| -------------- | ----------------------------------------------------------------------------------------- | ---------------------- |
| `lazyvimx`     | `setup()`, `config`                                                                       | Основная конфигурация  |
| `util.general` | `color_blend()`, `theme_is_dark()`, `get_flavor()`, `has_extra()`, `warn_missing_extra()` | Общие утилиты          |
| `util.layout`  | `get_size()`, `get_size_create()`, `increase_create()`, `decrease_create()`               | Управление компоновкой |

## См. также

- [CONFIGURATION.md](CONFIGURATION.md) - Руководство по конфигурации
- [ARCHITECTURE.md](ARCHITECTURE.md) - Техническая архитектура
- [EXTRAS.md](EXTRAS.md) - Справочник Extras
