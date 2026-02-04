# Руководство по Extras

> [!TIP]
> **🇬🇧 English version:** [EXTRAS.md](EXTRAS.md)

Полное руководство по всем 48 модулям extras lazyvimx.

## Содержание

- [Обзор](#обзор)
- [Core Extras](#core-extras)
- [UI Extras (19)](#ui-extras)
- [Coding Extras (2)](#coding-extras)
- [Motion Extras (6)](#motion-extras)
- [Buffer Extras (3)](#buffer-extras)
- [Git Extras (4)](#git-extras)
- [Language Extras (2)](#language-extras)
- [Linting Extras (2)](#linting-extras)
- [AI Extras (1)](#ai-extras)
- [DAP Extras (1)](#dap-extras)
- [Performance Extras (3)](#performance-extras)
- [Test Extras (1)](#test-extras)

## Обзор

Extras — это опциональные модули функций, которые расширяют функциональность LazyVim. Все extras полностью опциональны и могут быть включены индивидуально через UI `:LazyExtras` или путем импорта в вашей конфигурации.

### Включение Extras

**Через UI:**

```vim
:LazyExtras
```

**Через конфигурацию:**

```lua
{ import = "lazyvimx.extras.category.extra-name" }
```

**Включить все:**

```lua
{ import = "lazyvimx.extras.core.all" }
```

---

## Core Extras

Core extras обеспечивают оркестрацию и фундаментальные улучшения.

### core.all

**Import:** `lazyvimx.extras.core.all`

Полный lazyvimx опыт со всеми включенными функциями.

**Включает:**

- Все overrides
- Все extras
- Пользовательские комбинации клавиш
- Уведомления о рекомендуемых extras

**Использование:**

```lua
{ import = "lazyvimx.extras.core.all" }
```

**Уведомления:**
Проверяет рекомендуемые LazyVim extras:

- `coding.mini-surround`
- `coding.yanky`
- `ui.edgy`
- `ui.treesitter-context`

### core.overrides

**Import:** `lazyvimx.extras.core.overrides`

**Рекомендуется:** Да

Все переопределения плагинов (33 модуля в 4 категориях).

**Включает:**

- LazyVim core overrides (8 модулей)
- Snacks.nvim overrides (7 модулей)
- Bufferline overrides (6 модулей)
- Другие переопределения плагинов (13 модулей)

См. [ARCHITECTURE.md](./ARCHITECTURE.md#overrides-system) для подробностей.

### core.extras

**Import:** `lazyvimx.extras.core.extras`

Реестр всех 43 extras. Используйте это для включения всех функций одновременно.

### core.keys

**Import:** `lazyvimx.extras.core.keys`

Пользовательские комбинации клавиш для функций lazyvimx.

**Основные моменты:**

- `d` - Удалить без копирования
- `<C-S-j/k>` - Перемещение строк вверх/вниз
- `<leader>\` - Разделить окно вправо
- `<F5-F12>` - DAP отладка
- `<C-,/.>` - Sibling swap
- `gr` - Перейти к ссылкам (glance)
- `<leader>cr` - Переименование (live-rename)

См. [README.md#key-mappings](./README.md#key-mappings) для полного списка.

---

## UI Extras

UI extras улучшают визуальный опыт и интерфейс.

### ui.better-diagnostic

**Import:** `lazyvimx.extras.ui.better-diagnostic`

Встроенные диагностические сообщения отображаются на позиции курсора с иконками и цветами.

**Функции:**

- Отображение диагностики в одну строку
- Пользовательские иконки стрелок (→, ↓, ←, ↑)
- Вертикальные разделители
- Высокий приоритет (5000) виртуального текста
- Отключает нативный виртуальный текст

**Plugin:** `rachartier/tiny-inline-diagnostic.nvim`

**Пример отображения:**

```
function foo() {
  return bar  → Undefined variable 'bar'
}
```

### ui.better-insert-mode

**Import:** `lazyvimx.extras.ui.better-insert-mode`

Автоматически скрывает отвлекающие элементы UI в режиме вставки.

**Скрывает:**

- Treesitter context
- Индикаторы использования символов
- Направляющие отступов
- Virtual column

**Преимущества:**

- Более чистый опыт редактирования
- Меньше визуального беспорядка
- Лучший фокус

### ui.better-linenumbers

**Import:** `lazyvimx.extras.ui.better-linenumbers`

Умное отображение номеров строк в зависимости от контекста.

**Функции:**

- Отключает относительные номера в режиме командной строки
- Отключает все номера в терминальных буферах
- Автоматическое восстановление

### ui.highlighted-ansi-escape

**Import:** `lazyvimx.extras.ui.highlighted-ansi-escape`

Отображает ANSI escape последовательности с правильными цветами.

**Функции:**

- `:BaleiaColorize` - Раскрасить текущий буфер
- `:BaleiaLogs` - Показать логгер
- Авто-раскраска вывода DAP REPL

**Plugin:** `m00qek/baleia.nvim`

**Случаи использования:**

- Просмотр логов с цветами
- Вывод DAP REPL
- Терминальный вывод в буферах

### ui.highlighted-colors

**Import:** `lazyvimx.extras.ui.highlighted-colors`

Визуальные индикаторы цветовых кодов в файлах.

**Функции:**

- Подсвечивает hex цвета (#RRGGBB)
- Отображение виртуальной иконки (󱓻)
- Размещение в конце строки
- Автоматическое определение цвета

**Plugin:** `brenoprata10/nvim-highlight-colors`

**Пример:**

```css
background: #FF5733;  󱓻
color: #3498DB;       󱓻
```

### ui.symbol-usage

**Import:** `lazyvimx.extras.ui.symbol-usage`

Счетчики ссылок для символов в стиле JetBrains.

**Функции:**

- Показывает ссылки (󰌹)
- Показывает определения (󰳽)
- Показывает реализации (󰡱)
- Отображение в конце строки
- Счетчик вложенных функций

**Plugin:** `Wansmer/symbol-usage.nvim`

**Пример:**

```typescript
function calculate() {  󰌹 3 refs  󰳽 1 def
  // ...
}
```

### ui.diff-view

**Import:** `lazyvimx.extras.ui.diff-view`

Улучшенный diff view с согласованным размером панелей.

**Функции:**

- Панель файлов слева (ширина из layout utility)
- Панель истории внизу (высота из layout utility)
- Согласованный размер с другими боковыми панелями

**Plugin:** `sindrets/diffview.nvim`

**Команды:**

- `:DiffviewOpen` - Открыть diff view
- `:DiffviewFileHistory` - История файла

### ui.better-live-rename

**Import:** `lazyvimx.extras.ui.better-live-rename`

Live предварительный просмотр операций LSP rename.

**Функции:**

- Встроенное редактирование с предпросмотром
- Подтверждение через Enter (режимы n/v/i)
- Отмена через Ctrl+C

**Plugin:** `saecki/live-rename.nvim`

**Комбинация клавиш:** `<leader>cr` - Переименование (через core.keys)

### ui.better-reference-highlight

**Import:** `lazyvimx.extras.ui.better-reference-highlight`

Улучшенная подсветка LSP-ссылок с лучшей видимостью.

**Функции:**

- Жирная подсветка переднего плана вместо фона
- Разные цвета для ссылок чтения/записи
- Работает с Catppuccin (цвет rosewater)
- Работает с Tokyo Night (смешанный magenta)
- Нет загромождения фоном

**Highlights:**

- `LspReferenceRead` - Жирный rosewater/magenta
- `LspReferenceText` - Жирный rosewater/magenta
- `LspReferenceWrite` - Жирный rosewater/magenta с подчеркиванием (Tokyo Night)

**Темы:** Catppuccin, Tokyo Night (переопределяет настройки темы по умолчанию)

### ui.better-explorer

**Import:** `lazyvimx.extras.ui.better-explorer`

Интеграция файлового менеджера Yazi как основного проводника.

**Функции:**

- Плавающий UI на всё окно
- Без границ
- Быстрая навигация
- Богатый предварительный просмотр файлов
- Интеграция с neo-tree

**Plugin:** `mikavilpas/yazi.nvim`

**Комбинация клавиш:** `<leader>fy` (через core.keys)

### ui.simple-mode

**Import:** `lazyvimx.extras.ui.simple-mode`

Минимальный UI режим для просмотра (например, man страниц).

**Функции:**

- Определяет аргумент `+Man!`
- Отключает statusline, bufferline, neo-tree
- Убирает номера строк
- Чистый опыт просмотра

**Активируется через:**

```bash
nvim +Man! some-command
```

### ui.better-colorcolumn

**Import:** `lazyvimx.extras.ui.better-colorcolumn`

Индикатор виртуальной колонки на 120 символах.

**Функции:**

- Символ вертикальной черты (│)
- Интеграция с Snacks indent
- Исключенные типы файлов: dashboard

**Plugin:** `lukas-reineke/virt-column.nvim`

### ui.scrollbar

**Import:** `lazyvimx.extras.ui.scrollbar`

Визуальный scrollbar в текущем окне.

**Функции:**

- Только текущее окно
- Исключает специальные типы файлов
- Скрыт в режиме вставки
- Индикаторы выровнены вправо

**Plugin:** `dstein64/nvim-scrollview`

### ui.winbar

**Import:** `lazyvimx.extras.ui.winbar`

Панель окна с именем файла и иконкой.

**Функции:**

- Иконка типа файла
- Красивое отображение пути
- Жирное форматирование
- Прозрачный фон
- Отключено для специальных буферов

**Plugin:** `nvim-lualine/lualine.nvim`

### ui.bolder-separators

**Import:** `lazyvimx.extras.ui.bolder-separators`

Жирные Unicode разделители окон.

**Символы:**

- Горизонтальные: ━
- Вертикальные: ┃
- Пересечения: ┳, ┻, ╋, ┫, ┣

**Визуальный эффект:**
Более заметные разделения окон.

### ui.better-cursorline

**Import:** `lazyvimx.extras.ui.better-cursorline`

Умная cursorline, которая следует за активным окном.

**Функции:**

- Включена в режиме вставки
- Всегда подсвечивает номер строки
- Исключает специальные типы файлов
- Учитывает активное окно

**Plugin:** `tummetott/reticle.nvim`

### ui.better-whitespace

**Import:** `lazyvimx.extras.ui.better-whitespace`

Визуализация пробелов в стиле VSCode в визуальном режиме.

**Функции:**

- Показывает пробелы (·)
- Показывает табы (→)
- Показывает nbsp (␣)
- Unix окончание строки (↩)
- Активно только в визуальном режиме

**Plugin:** `mcauley-penney/visual-whitespace.nvim`

### ui.peek-preview

**Import:** `lazyvimx.extras.ui.peek-preview`

Просмотр определений и ссылок в стиле VSCode.

**Функции:**

- Авто-переход для одного результата
- Окно предпросмотра для нескольких результатов
- Пользовательские границы (▁, ▔)
- Быстрая навигация

**Plugin:** `dnlhc/glance.nvim`

**Комбинация клавиш:** `gr` - Перейти к ссылкам (через core.keys)

### ui.better-float

**Import:** `lazyvimx.extras.ui.better-float`

Согласованные закругленные границы для всех плавающих окон.

**Применяется к:**

- DAP UI
- Mason
- LSP (hover, signature help)
- Neo-tree
- Noice
- Terminals
- Lazygit

**Функции:**

- Стиль закругленных границ
- Пользовательские размеры
- Конфигурация backdrop
- Нулевой winblend для zen mode

---

## Coding Extras

Coding extras улучшают рабочие процессы программирования.

### coding.emmet

**Import:** `lazyvimx.extras.coding.emmet`

Раскрытие Emmet аббревиатур для HTML/CSS.

**Функции:**

- Emmet language server
- Команда `:EmmetWrap`
- Работает с HTML, CSS, JSX, TSX

**Plugins:**

- `neovim/nvim-lspconfig`
- `olrtg/nvim-emmet`

**Пример:**

```
div.container>ul>li*3  →  Раскрыть с Emmet
```

**Комбинация клавиш:** Пользовательская (проверьте `:EmmetWrap`)

### coding.comments

**Import:** `lazyvimx.extras.coding.comments`

Улучшенное комментирование с генерацией документации.

**Функции:**

- Комментирование с учетом контекста Tree-sitter
- Генерация JSDoc/TSDoc
- Множественные форматы документации
- Пользовательские строки комментариев

**Plugins:**

- `nvim-mini/mini.comment`
- `JoosepAlviste/nvim-ts-context-commentstring`
- `kkoomen/vim-doge`

**Комбинации клавиш:**

- `gcc` - Переключить комментарий
- `gcd` - Сгенерировать документацию

**JavaScript конфигурация:**

- Без деструктуризации props
- Опускает избыточные типы
- Умная генерация документации

---

## Motion Extras

Motion extras улучшают навигацию по коду.

### motions.splitting-joining-blocks

**Import:** `lazyvimx.extras.motions.splitting-joining-blocks`

Манипуляция блоками на основе Tree-sitter.

**Функции:**

- Разделение многострочных структур
- Объединение в одну строку
- Работает с: объектами, массивами, функциями, JSX

**Plugin:** `Wansmer/treesj`

**Пример:**

```javascript
// Split
{ foo: 'bar', baz: 'qux' }
↓
{
  foo: 'bar',
  baz: 'qux'
}

// Join (обратно)
```

### motions.better-cursor-move

**Import:** `lazyvimx.extras.motions.better-cursor-move`

Предотвращает движение курсора во время операций shift/filter.

**Функции:**

- Курсор остается на месте при сдвиге
- Совместимо с VSCode
- Предсказуемое поведение

**Plugin:** `gbprod/stay-in-place.nvim`

### motions.better-move-between-words

**Import:** `lazyvimx.extras.motions.better-move-between-words`

Улучшенные движения w/e/b с поддержкой подслов.

**Функции:**

- Навигация по подсловам (camelCase)
- Пропуск незначительной пунктуации
- Поддержка UTF-8
- Совместимо с VSCode

**Plugin:** `chrisgrieser/nvim-spider`

**Пример:**

```javascript
camelCaseVariable
^    ^    ^        (останавливается на подсловах)
```

**Комбинации клавиш:**

- `w` - Следующее слово/подслово
- `e` - Конец слова/подслова
- `b` - Предыдущее слово/подслово

### motions.sibling-move

**Import:** `lazyvimx.extras.motions.sibling-move`

Навигация по соседним элементам с учетом Tree-sitter.

**Функции:**

- Навигация по синтаксическим узлам
- Подсветка при перемещении (250мс)
- Умные переходы

**Plugin:** `aaronik/treewalker.nvim`

**Навигация:**
Перемещение между параметрами функции, элементами массива и т.д.

### motions.sibling-swap

**Import:** `lazyvimx.extras.motions.sibling-swap`

Перестановка соседних элементов с использованием Tree-sitter.

**Функции:**

- Перестановка параметров
- Перестановка элементов массива
- Перестановка свойств объекта
- Визуальная обратная связь

**Plugin:** `Wansmer/sibling-swap.nvim`

**Комбинации клавиш:**

- `<C-,>` - Поменять с предыдущим
- `<C-.>` - Поменять со следующим

### motions.langmapper

**Import:** `lazyvimx.extras.motions.langmapper`

**Рекомендуется:** Да

Поддержка русской раскладки клавиатуры.

**Функции:**

- Автоматический перевод keymap
- Переключение раскладки EN/RU
- Интеграция с Which-key
- Интеграция с Snacks
- getcharstr хак для правильного перевода

**Plugin:** `Wansmer/langmapper.nvim`

**Случай использования:**
Использование Vim движений с русской раскладкой клавиатуры без переключения.

---

## Buffer Extras

Buffer extras улучшают управление буферами.

### buf.tab-scope

**Import:** `lazyvimx.extras.buf.tab-scope`

Изоляция буферов внутри вкладок.

**Функции:**

- Каждая вкладка имеет свой список буферов
- Независимая навигация по буферам для каждой вкладки
- Более чистая организация рабочего пространства

**Plugin:** `tiagovla/scope.nvim`

### buf.delete-no-name

**Import:** `lazyvimx.extras.buf.delete-no-name`

Авто-удаление пустых [No Name] буферов.

**Функции:**

- Срабатывает на BufHidden
- Только безымянные, неизмененные буферы
- Безопасное удаление через Snacks

**Поведение:**
Открытие нового файла автоматически очищает пустые буферы.

### buf.delete-inactive

**Import:** `lazyvimx.extras.buf.delete-inactive`

Автоматическая очистка неактивных буферов.

**Функции:**

- Порог неактивности 30 минут
- Авто-удаление при удалении исходного файла
- Уведомление при авто-закрытии
- Умный жизненный цикл буфера

**Plugin:** `chrisgrieser/nvim-early-retirement`

**Преимущества:**

- Сниженное использование памяти
- Более чистый список буферов
- Автоматическая очистка

---

## Git Extras

Git extras улучшают рабочие процессы контроля версий.

### git.fugitive

**Import:** `lazyvimx.extras.git.fugitive`

Всеобъемлющая интеграция с Git.

**Функции:**

- Полный набор команд Git
- Интеграция с GitHub (GBrowse)
- Интеграция с GitLab
- Аутентификация по токену

**Plugins:**

- `tpope/vim-fugitive`
- `tpope/vim-rhubarb` (GitHub)
- `shumphrey/fugitive-gitlab.vim` (GitLab)

**Команды:**

- `:Git` - Выполнить git команды
- `:GBrowse` - Открыть в GitHub/GitLab
- `:Gdiff` - Показать diff

### git.remote-view

**Import:** `lazyvimx.extras.git.remote-view`

Открытие и просмотр удаленных репозиториев локально.

**Функции:**

- Клонирование и открытие в новой вкладке
- Авто-открытие README
- Интеграция с Neo-tree
- Пользовательские функции открытия

**Plugin:** `moyiz/git-dev.nvim`

**Команды:**

- `:GitDevOpen <url>` - Клонировать и открыть
- `:GitDevRemoteOpen` - Открыть удаленный
- `:GitDevRemoteEnterAndOpen` - Войти и открыть

### git.gitlab

**Import:** `lazyvimx.extras.git.gitlab`

Ревью GitLab MR внутри Neovim.

**Функции:**

- Ревью merge requests
- Дерево обсуждений
- Опция squash merge
- Комментарии к diff
- Одобрение/отклонение MR

**Plugin:** `harrisoncramer/gitlab.nvim`

**Требует:** `ui.diff-view` extra (предупреждает если отсутствует)

**Комбинации клавиш:** `<leader>gl*` (через core.keys)

**Команды:**

- `:GitLabMRs` - Список MR
- `:GitLabMRReview` - Ревью MR
- `:GitLabMRApprove` - Одобрить MR

### git.conflicts

**Import:** `lazyvimx.extras.git.conflicts`

Визуальное разрешение Git конфликтов.

**Функции:**

- Уведомления об обнаружении конфликтов
- Визуальные маркеры конфликтов
- Уведомления о разрешении
- Троттлинг уведомлений (3с)

**Plugin:** `akinsho/git-conflict.nvim`

**Маркеры:**

```
<<<<<<< HEAD
Текущие изменения
=======
Входящие изменения
>>>>>>> branch
```

---

## Language Extras

Language extras добавляют поддержку конкретных языков.

### lang.ejs

**Import:** `lazyvimx.extras.lang.ejs`

Поддержка EJS (Embedded JavaScript) шаблонов.

**Функции:**

- Регистрируется как eruby filetype
- Парсер встроенных шаблонов
- Интеграция с Tree-sitter
- Подсветка синтаксиса

**Plugin:** `nvim-treesitter/nvim-treesitter`

**Расширения файлов:** `.ejs`

### lang.css

**Import:** `lazyvimx.extras.lang.css`

Улучшенная поддержка CSS/SCSS.

**Функции:**

- CSS LSP со сниппетами
- Tree-sitter для CSS/SCSS
- Форматирование Prettier (если extra включен)
- Интеграция со Stylelint
- Поддержка ESLint

**Plugins:**

- `neovim/nvim-lspconfig`
- `nvim-treesitter/nvim-treesitter`
- `stevearc/conform.nvim` (опционально)

**Форматтеры:**

- Prettier (CSS/SCSS)
- Stylelint (CSS/SCSS)

---

## Linting Extras

Linting extras добавляют инструменты проверки качества кода.

### linting.cspell

**Import:** `lazyvimx.extras.linting.cspell`

Интеграция с проверкой орфографии CSpell.

**Функции:**

- Авто-включение если cspell найден в проекте
- Применяется ко всем типам файлов
- Определение на уровне проекта

**Plugin:** `mfussenegger/nvim-lint`

**Настройка:**
Добавьте `cspell.json` в ваш проект:

```json
{
  "version": "0.2",
  "language": "en",
  "words": ["customword"]
}
```

### linting.stylelint

**Import:** `lazyvimx.extras.linting.stylelint`

Обеспечивает установку stylelint.

**Функции:**

- Авто-установка через Mason
- Линтинг CSS/SCSS
- Работает с lang.css extra

**Plugin:** `mason-org/mason.nvim`

---

## AI Extras

AI extras интегрируют AI ассистентов для программирования.

### ai.avante

**Import:** `lazyvimx.extras.ai.avante`

Эмуляция Cursor AI IDE для Neovim.

**Функции:**

- Интеграция с OpenAI GPT-4o
- Встроенные предложения кода
- Интерфейс чата
- Интеграция с file selector
- Источники Blink.cmp
- Поддержка render-markdown

**Plugin:** `yetone/avante.nvim`

**Конфигурация:**

```lua
{
	provider = "openai",
	model = "gpt-4o",
	temperature = 0,
	max_tokens = 8192,
}
```

**Комбинации клавиш:** `<leader>a*` (через core.keys)

**Требования:**

- OpenAI API ключ
- Интернет соединение

---

## DAP Extras

DAP extras добавляют возможности отладки.

### dap.vscode-js

**Import:** `lazyvimx.extras.dap.vscode-js`

Отладчик JavaScript/TypeScript.

**Функции:**

- Отладка Chrome
- Отладка Node.js
- Поддержка source map
- Пропуск node_modules
- Поддержка Svelte

**Plugins:**

- `mxsdev/nvim-dap-vscode-js`
- `microsoft/vscode-js-debug`

**Конфигурации:**

1. Chrome (порт 8080)
2. Attach к node --inspect
3. Запуск файла в node (только JS)

**Комбинации клавиш:**

- `<F5>` - Продолжить
- `<F10>` - Шаг над
- `<F11>` - Шаг внутрь
- `<F12>` - Шаг наружу

**Требует:** `dap.core` extra (предупреждает если отсутствует)

---

## Performance Extras

Performance extras оптимизируют Neovim.

### perf.stop-inactive-lsp

**Import:** `lazyvimx.extras.perf.stop-inactive-lsp`

**Статус:** Отключено по умолчанию

Сборщик мусора для неактивных LSP клиентов.

**Функции:**

- Авто-остановка неиспользуемых LSP клиентов
- Освобождение RAM
- Настраиваемые пороги

**Plugin:** `zeioth/garbage-day.nvim`

**Примечание:** В настоящее время отключено. Включайте на свой риск.

### perf.local-config

**Import:** `lazyvimx.extras.perf.local-config`

Загрузка конфигурации на уровне проекта.

**Функции:**

- Поддерживает `.nvim.lua` и `.config/nvim.lua`
- Тихий режим (без уведомлений)
- Настройка для каждого проекта

**Plugin:** `klen/nvim-config-local`

**Пример `.nvim.lua`:**

```lua
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

require("lspconfig").tsserver.setup({
	-- Специфичная для проекта LSP конфигурация
})
```

### perf.restore-last-colorscheme

**Import:** `lazyvimx.extras.perf.restore-last-colorscheme`

Автоматическое восстановление последней использованной цветовой схемы при запуске.

**Функции:**

- Запоминает цветовую схему между сеансами
- Быстрое восстановление при запуске
- Не требует ручной настройки
- Интегрируется с переключением тем lazyvimx

**Plugin:** `raddari/last-color.nvim`

**Применение:** Полезно при частой смене цветовых схем и желании сохранить предпочтение между сеансами Neovim.

---

## Test Extras

Test extras интегрируют фреймворки тестирования.

### test.jest

**Import:** `lazyvimx.extras.test.jest`

Фреймворк тестирования Jest для Neotest.

**Функции:**

- Обнаружение Jest тестов
- Запуск тестов из редактора
- Вывод тестов в Neotest
- Переменная окружения CI

**Plugins:**

- `nvim-neotest/neotest`
- `haydenmeade/neotest-jest`

**Команды:**

- `:Neotest run` - Запустить ближайший тест
- `:Neotest run file` - Запустить тесты файла
- `:Neotest summary` - Показать сводку

**Требует:** `test.core` extra (предупреждает если отсутствует)

---

## Сводка по Extras

| Категория   | Количество | Описание                                        |
| ----------- | ---------- | ----------------------------------------------- |
| Core        | 4          | Оркестрация и основной функционал               |
| UI          | 18         | Визуальные улучшения и интерфейс                |
| Coding      | 2          | Инструменты программирования и рабочие процессы |
| Motions     | 6          | Улучшения навигации                             |
| Buffer      | 3          | Управление буферами                             |
| Git         | 4          | Интеграция контроля версий                      |
| Language    | 2          | Поддержка языков                                |
| Linting     | 2          | Инструменты проверки качества кода              |
| AI          | 1          | AI ассистенты для программирования              |
| DAP         | 1          | Поддержка отладки                               |
| Performance | 3          | Оптимизация                                     |
| Test        | 1          | Фреймворки тестирования                         |
| **Всего**   | **48**     |                                                 |

## Рекомендуемые Extras

Для лучшего опыта, включите:

1. `core.all` - Все функции
2. `motions.langmapper` - Если используете русскую клавиатуру
3. `ui.better-diagnostic` - Лучшее отображение ошибок
4. `ui.better-float` - Согласованный UI
5. `git.conflicts` - Если используете Git
6. `coding.comments` - Улучшенное комментирование

## Следующие шаги

- См. [CONFIGURATION.md](CONFIGURATION.md) для деталей настройки
- См. [API.md](API.md) для утилитарных функций
- См. [ARCHITECTURE.md](ARCHITECTURE.md) для технических деталей
