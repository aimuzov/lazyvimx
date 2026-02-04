# lazyvimx

<div align="center">

![Версия](https://img.shields.io/badge/версия-1.5.0-blue.svg)
![Neovim](https://img.shields.io/badge/Neovim-0.10+-green.svg)
![Лицензия](https://img.shields.io/badge/лицензия-Apache--2.0-orange.svg)
![Extras](https://img.shields.io/badge/extras-48-purple.svg)

</div>

> [!TIP]
> **🇬🇧 English version:** [README.md](README.md)

**Расширенная конфигурация LazyVim с обширными настройками, улучшениями UI и оптимизацией рабочего процесса.**

lazyvimx — это комплексный слой улучшений, построенный поверх [LazyVim](https://github.com/LazyVim/LazyVim), который предоставляет 48 опциональных расширений (extras) и 33 модуля переопределений (overrides) для создания высококачественного и функционального Neovim.

## ✨ Возможности

### 🎨 Визуальные улучшения

- **Продвинутая кастомизация тем** с глубокой настройкой Catppuccin и Tokyo Night
- **Автоматическое переключение темы** в зависимости от светлого/темного режима системы (только для [macOS](https://github.com/aimuzov/dotfiles/tree/main/private_Library/ThemeSwitcher))
- **Улучшенные UI компоненты** с единообразными скругленными рамками и кастомными иконками
- **Улучшенная строка состояния** с индикаторами режимов и визуальными элементами
- **Улучшенная панель приветствия** с кастомным ASCII-артом и стилизованными секциями
- **Индикаторы использования символов** показывают ссылки и реализации inline

### 🚀 Повышение продуктивности

- **Умное управление буферами** с группами, автоочисткой и изоляцией по табам
- **Улучшенная навигация по коду** с tree-sitter навигацией
- **Улучшенное отображение диагностики** с inline сообщениями
- **Улучшения для работы с Git** включая интеграцию с GitLab MR и разрешение конфликтов
- **Продвинутое автодополнение** с интеграцией Blink.cmp
- **Поддержка AI-ассистента** через Avante

### ⚙️ Качество жизни

- **Поддержка русской клавиатуры** через langmapper
- **Повторяемые действия** для операций с буферами
- **Автосохранение в chezmoi** при обновлениях LazyVim
- **Поддержка локальной конфигурации проекта**
- **Интеграция с VSCode** для гибридных рабочих процессов
- **Оптимизация производительности** включая очистку неактивных LSP

## 📦 Установка

### Требования

- Neovim >= 0.10.0

### Быстрый старт

> **💡 Реальный пример**: См. [конфигурацию автора](https://github.com/aimuzov/dotfiles/blob/main/dot_config/nvim/init.lua) для production setup.

1. **Создайте `~/.config/nvim/init.lua` со следующим содержимым:**

```lua
local lazy_opts = {
  spec = { { "aimuzov/lazyvimx", import = "lazyvimx.boot" } },

  install = { colorscheme = { "catppuccin", "tokyonight" } },
  checker = { enabled = true, notify = false },
  change_detection = { enabled = false },
  diff = { cmd = "diffview.nvim" },

  ui = {
    backdrop = 100,
    border = "rounded",
    icons = { keys = "󰥻" },
  },
}

-- Bootstrap lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_url = "https://github.com/folke/lazy.nvim.git"

if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazy_url, lazy_path })
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup(lazy_opts)
```

2. **Запустите Neovim:**

```bash
nvim
```

Вот и всё! lazyvimx автоматически установит LazyVim и все необходимые плагины при первом запуске.

3. **Настройте lazyvimx (опционально):**

Вы можете настроить lazyvimx двумя способами:

**Вариант А:** Добавьте `opts` прямо в `init.lua`:

```lua
local lazy_opts = {
  spec = {
    {
      "aimuzov/lazyvimx",
      import = "lazyvimx.boot",
      opts = {
        colorscheme = "catppuccin",
        colorscheme_flavors = {
          catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
          tokyonight = { "tokyonight-storm", "tokyonight-day" },
        },
        bufferline_groups = {
          -- Определите кастомные группы буферов
          -- ["name"] = "regex_pattern",
        }
      }
    }
  }
  -- ... остальные настройки
}
```

**Вариант Б:** Создайте отдельный файл `~/.config/nvim/lua/plugins/lazyvimx.lua`:

```lua
return {
  "aimuzov/lazyvimx",
  opts = {
    colorscheme = "catppuccin",
    colorscheme_flavors = {
      catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
      tokyonight = { "tokyonight-storm", "tokyonight-day" },
    },
    bufferline_groups = {
      -- Определите кастомные группы буферов
      -- ["name"] = "regex_pattern",
    },
  },
}
```

4. **Включите расширения (extras):**

Используйте UI для выбора расширений LazyVim (`:LazyExtras`) чтобы включить расширения lazyvimx (рекомендуется этот способ), или добавьте их в конфигурацию:

```lua
-- В lua/plugins/extras.lua
return {
  -- Включает все улучшения для lazyvim
  { import = "lazyvimx.extras.core.overrides" },
  -- Добавьте больше расширений по необходимости
  { import = "lazyvimx.extras.ui.better-diagnostic" },
  { import = "lazyvimx.extras.motions.langmapper" },
}
```

## 🗂️ Структура проекта

```
lazyvimx/
├── lua/lazyvimx/
│   ├── boot.lua             # Загрузочная конфигурация
│   ├── init.lua             # Главный модуль с функцией setup
│   ├── extras/              # Опциональные модули (всего 48)
│   │   ├── core/            # Базовые улучшения (overrides, keys)
│   │   ├── ui/              # Улучшения UI (19 модулей)
│   │   ├── coding/          # Инструменты программирования (2 модуля)
│   │   ├── motions/         # Улучшения навигации (6 модулей)
│   │   ├── buf/             # Управление буферами (3 модуля)
│   │   ├── git/             # Git интеграция (4 модуля)
│   │   ├── lang/            # Поддержка языков (2 модуля)
│   │   ├── linting/         # Инструменты линтинга (2 модуля)
│   │   ├── ai/              # AI-ассистенты (1 модуль)
│   │   ├── dap/             # Отладка (1 модуль)
│   │   ├── perf/            # Производительность (3 модуля)
│   │   └── test/            # Тестирование (1 модуль)
│   ├── overrides/           # Кастомизация плагинов (всего 33)
│   │   ├── lazyvim/         # Переопределения LazyVim (8 модулей)
│   │   ├── snacks/          # Переопределения Snacks.nvim (7 модулей)
│   │   ├── bufferline/      # Переопределения Bufferline (6 модулей)
│   │   └── other/           # Другие плагины (13 модулей)
│   └── util/                # Утилиты
│       ├── general.lua      # Общие утилиты
│       └── layout.lua       # Управление макетом
└── init.lua                 # Точка входа с защитой
```

## 🎯 Базовые расширения

### Рекомендуемая настройка

Включите все базовые улучшения `core.all` через `:LazyExtras` (рекомендуется) или же добавьте импорт в конфигурацию:

```lua
{ import = "lazyvimx.extras.core.all" }
```

Это включает:

- **Overrides**: Все кастомизации плагинов
- **Extras**: Все доступные расширения
- **Keys**: Кастомные горячие клавиши
- **Notifications**: Предупреждения об отсутствующих расширениях

### Отдельные базовые компоненты

```lua
{ import = "lazyvimx.extras.core.overrides" }  -- Переопределения плагинов
{ import = "lazyvimx.extras.core.extras" }     -- Все расширения
{ import = "lazyvimx.extras.core.keys" }       -- Кастомные горячие клавиши
```

## 📚 Документация

- **[ARCHITECTURE.ru.md](docs/ARCHITECTURE.ru.md)** - Техническая архитектура и детали реализации ([🇬🇧](docs/ARCHITECTURE.md))
- **[CONFIGURATION.ru.md](docs/CONFIGURATION.ru.md)** - Руководство по настройке и опции ([🇬🇧](docs/CONFIGURATION.md))
- **[EXTRAS.ru.md](docs/EXTRAS.ru.md)** - Полное руководство по всем 48 расширениям ([🇬🇧](docs/EXTRAS.md))
- **[API.ru.md](docs/API.ru.md)** - Справочник по API и утилитам ([🇬🇧](docs/API.md))

## 🎨 Выделенные расширения

### UI улучшения

- `ui.better-diagnostic` - Inline сообщения диагностики
- `ui.better-float` - Единообразный стиль плавающих окон
- `ui.symbol-usage` - Счетчики ссылок/определений
- `ui.better-explorer` - Интеграция с файловым менеджером Yazi
- `ui.winbar` - Путь к файлу в панели окна

### Инструменты программирования

- `coding.emmet` - Расширение HTML/CSS
- `coding.comments` - Улучшенное комментирование с генерацией документации

### Навигация

- `motions.langmapper` - **Поддержка русской клавиатуры**
- `motions.better-move-between-words` - Навигация по подсловам
- `motions.sibling-swap` - Перемещение на основе Tree-sitter
- `motions.splitting-joining-blocks` - Умная манипуляция блоками

### Git интеграция

- `git.gitlab` - Ревью GitLab MR
- `git.conflicts` - Визуальное разрешение конфликтов
- `git.remote-view` - Открытие удаленных репозиториев локально

### AI и тестирование

- `ai.avante` - Эмуляция Cursor AI IDE
- `test.jest` - Фреймворк тестирования Jest

## ⌨️ Горячие клавиши

lazyvimx добавляет множество кастомных привязок клавиш:

### Базовые операции

| Клавиша          | Режим   | Описание                           |
| ---------------- | ------- | ---------------------------------- |
| `d`              | n, v    | Удаление без копирования в буфер   |
| `<C-S-j>`        | n, i, v | Переместить строку/выделение вниз  |
| `<C-S-k>`        | n, i, v | Переместить строку/выделение вверх |
| `<leader>\`      | n       | Разделить окно вправо              |
| `<leader>ch`     | n       | Открыть shell (cht.sh)             |
| `<leader>ll`     | n       | Открыть Lazy dashboard             |
| `<leader>lx`     | n       | Открыть Lazy extras                |
| `<leader>uz`     | n       | Переключить zen режим              |
| `<leader>uq`     | n       | Открыть dashboard                  |
| `<leader><tab>r` | n       | Переименовать таб                  |

### Файлы и буферы

| Клавиша           | Режим | Описание                        |
| ----------------- | ----- | ------------------------------- |
| `<leader><space>` | n     | Найти файлы (smart)             |
| `<leader>fy`      | n     | Найти файлы (yazi)              |
| `<leader>fY`      | n     | Найти файлы (yazi prev session) |
| `<leader>bg`      | n, v  | Выбрать буфер                   |
| `<leader>bm[`     | n     | Переместить буфер (prev)        |
| `<leader>bm]`     | n     | Переместить буфер (next)        |
| `<leader>b<tab>`  | n     | Переместить буфер в другой таб  |
| `H`               | n     | Предыдущий буфер                |
| `L`               | n     | Следующий буфер                 |

### Навигация и движение

| Клавиша   | Режим   | Описание                          |
| --------- | ------- | --------------------------------- |
| `[x`      | n       | Перейти к контексту treesitter    |
| `w`       | n, o, x | Движение вперед (spider)          |
| `b`       | n, o, x | Движение назад (spider)           |
| `e`       | n, o, x | Движение к концу слова (spider)   |
| `cw`      | n       | Изменить слово (spider)           |
| `<C-f>`   | i       | Движение вперед в insert (spider) |
| `<C-b>`   | i       | Движение назад в insert (spider)  |
| `<C-A-h>` | n       | TreeWalker влево                  |
| `<C-A-l>` | n       | TreeWalker вправо                 |
| `<C-A-j>` | n       | TreeWalker вниз                   |
| `<C-A-k>` | n       | TreeWalker вверх                  |
| `<C-A-.>` | n       | TreeWalker поменять вниз          |
| `<C-A-,>` | n       | TreeWalker поменять вверх         |

### Управление окнами

| Клавиша     | Режим   | Описание              |
| ----------- | ------- | --------------------- |
| `<C-Up>`    | n, v, t | Увеличить высоту окна |
| `<C-Down>`  | n, v, t | Уменьшить высоту окна |
| `<C-Left>`  | n, v, t | Уменьшить ширину окна |
| `<C-Right>` | n, v, t | Увеличить ширину окна |

### LSP и код

| Клавиша      | Режим | Описание                          |
| ------------ | ----- | --------------------------------- |
| `gr`         | n     | Перейти к ссылкам (glance)        |
| `<leader>cr` | n     | Переименование (live-rename)      |
| `<leader>cw` | n, v  | Обернуть emmet abbreviation       |
| `<C-.>`      | n     | Поменять sibling узел вправо      |
| `<C-,>`      | n     | Поменять sibling узел влево       |
| `<leader>ct` | n     | Split/Join блок (автоопределение) |
| `<leader>c\` | n     | Split блок кода                   |
| `<leader>cj` | n     | Join блок кода                    |

### Git операции

| Клавиша       | Режим | Описание                          |
| ------------- | ----- | --------------------------------- |
| `<leader>ghP` | n     | Предпросмотр hunk                 |
| `go`          | n     | Открыть в браузере (fugitive)     |
| `go`          | v     | Открыть диапазон в браузере       |
| `gx`          | n     | Открыть удаленный git репозиторий |
| `gX`          | n     | Войти в удаленный git репозиторий |

### GitLab операции

| Клавиша       | Режим | Описание                           |
| ------------- | ----- | ---------------------------------- |
| `<leader>gLA` | n     | Одобрить MR                        |
| `<leader>gLc` | n     | Создать комментарий                |
| `<leader>gLc` | v     | Создать multiline комментарий      |
| `<leader>gLC` | v     | Создать комментарий с предложением |
| `<leader>gLd` | n     | Переключить обсуждение             |
| `<leader>gLe` | n     | Выбрать merge request              |
| `<leader>gLM` | n     | Слить MR                           |
| `<leader>gLm` | n     | Перейти к дереву обсуждений        |
| `<leader>gLn` | n     | Создать заметку                    |
| `<leader>gLo` | n     | Открыть в браузере                 |
| `<leader>gLp` | n     | Pipeline                           |
| `<leader>gLr` | n     | Review                             |
| `<leader>gLR` | n     | Отозвать                           |
| `<leader>gLs` | n     | Сводка                             |

### DAP (отладка)

| Клавиша | Режим | Описание              |
| ------- | ----- | --------------------- |
| `<F5>`  | n     | Продолжить            |
| `<F10>` | n     | Шаг через (step over) |
| `<F11>` | n     | Шаг в (step into)     |
| `<F12>` | n     | Шаг из (step out)     |

См. [extras/core/keys.lua](./lua/lazyvimx/extras/core/keys.lua) для полного списка.

## 🔧 Конфигурация

### Цветовая схема

lazyvimx поддерживает автоматическое переключение между светлым/темным вариантами:

```lua
require("lazyvimx").setup({
  colorscheme = "catppuccin",
  colorscheme_flavors = {
    catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
  }
})
```

Система автоматически переключается между темным (индекс 1) и светлым (индекс 2) в зависимости от системной темы (только для [macOS](https://github.com/aimuzov/dotfiles/tree/main/private_Library/ThemeSwitcher)).

### Группы буферов

Определите кастомные группы bufferline:

```lua
require("lazyvimx").setup({
   bufferline_groups = {
     ["React"] = "%.tsx$",
     ["Tests"] = "%.test%.",
   }
})
```

## 🤝 Интеграция

### Chezmoi

lazyvimx автоматически синхронизирует `lazy-lock.json` и `lazyvim.json` в chezmoi при обновлениях, если установлена переменная окружения `DOTFILES_SRC_PATH`.

### VSCode

Специальный режим интеграции с VSCode:

- Синхронизация индикатора режима
- Адаптированные горячие клавиши
- Нативная интеграция переименования VSCode

### macOS

- Определение системной темы для автопереключения цветовых схем
- Интеграция с корзиной для безопасного удаления файлов в neo-tree
- Системные команды открытия

## 🌟 Философия

lazyvimx улучшает LazyVim, следуя принципам:

1. **Сохранение дизайна LazyVim** - Все улучшения опциональны через extras
2. **Поддержание консистентности** - Единая тема и визуальный язык
3. **Улучшение юзабилити** - Умные настройки по умолчанию и оптимизация рабочих процессов
4. **Поддержка кастомизации** - Гибкая система конфигурации
5. **Обеспечение качества** - Внимательное отношение к полировке и деталям

## 📊 Статистика

- **48 опциональных расширений** в 11 категориях
- **33 модуля переопределений** для глубокой кастомизации
- **150+ кастомных подсветок** для темы Catppuccin
- **70+ кастомных подсветок** для темы Tokyo Night
- **30+ кастомных горячих клавиш**

## 🔗 Ссылки

- [Пример использования](https://github.com/aimuzov/dotfiles/blob/main/dot_config/nvim/init.lua#L6-L7)
- [Обсуждение](https://t.me/aimuzov_dotfiles)
- [LazyVim](https://github.com/LazyVim/LazyVim)

## 📈 Активность

![Repo Activity](https://repobeats.axiom.co/api/embed/f5453bcfc3ad93005a4d3b73d0681450ff7ca5d3.svg "Repobeats analytics image")

## 📄 Лицензия

Этот проект следует той же лицензии, что и LazyVim.

## 🙏 Благодарности

Построен поверх превосходного [LazyVim](https://github.com/LazyVim/LazyVim) от [folke](https://github.com/folke).

---

**Автор**: Aleksey Imuzov ([@aimuzov](https://github.com/aimuzov))
