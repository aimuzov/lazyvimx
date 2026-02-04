# Руководство по решению проблем

> [!TIP]
> **🇬🇧 English version:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

Решения распространённых проблем lazyvimx.

## Оглавление

- [Проблемы установки](#проблемы-установки)
- [Extras не работают](#extras-не-работают)
- [Темы и цветовые схемы](#темы-и-цветовые-схемы)
- [Проблемы производительности](#проблемы-производительности)
- [Конфликты плагинов](#конфликты-плагинов)
- [Проблемы LSP](#проблемы-lsp)
- [Проблемы с горячими клавишами](#проблемы-с-горячими-клавишами)
- [Проблемы специфичные для macOS](#проблемы-специфичные-для-macos)
- [Получение помощи](#получение-помощи)

## Проблемы установки

### lazyvimx extras не появляются в :LazyExtras

**Симптомы**: Не видно секции lazyvimx в UI `:LazyExtras`

**Решения**:

1. **Проверьте импорт boot**:
   ```lua
   -- В спецификации lazy.nvim
   { "aimuzov/lazyvimx", import = "lazyvimx.boot" }
   ```

2. **Проверьте источники extras**:
   ```vim
   :lua vim.print(require("lazyvim.util.extras").sources)
   ```
   Должна быть запись `[ 󰬟 ]` для lazyvimx.

3. **Перезапустите Neovim** после добавления импорта boot

4. **Обновите плагины**:
   ```vim
   :Lazy update
   ```

### Плагины не устанавливаются

**Симптомы**: Ошибки во время `:Lazy install` или первого запуска

**Решения**:

1. **Проверьте версию Neovim**:
   ```vim
   :version
   ```
   Должна быть >= 0.10.0. Обновите при необходимости.

2. **Проверьте интернет-соединение**: Lazy.nvim нужно скачивать плагины

3. **Очистите кэш и попробуйте снова**:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.local/state/nvim
   nvim
   ```

4. **Проверьте логи**:
   ```vim
   :Lazy log
   ```

### Конфигурация lazyvimx не загружается

**Симптомы**: Опции `require("lazyvimx").setup()` игнорируются

**Решения**:

1. **Проверьте расположение файла**:
   - Должен быть в `lua/config/lazyvimx.lua` ИЛИ
   - В спецификации плагина с `opts = { ... }`

2. **Проверьте таймин**:
   ```lua
   {
     "aimuzov/lazyvimx",
     opts = {
       colorscheme = "catppuccin",
     },
   }
   ```

3. **Проверьте загрузку конфига**:
   ```vim
   :lua vim.print(require("lazyvimx").config)
   ```

## Extras не работают

### Extra включен но не активен

**Симптомы**: Extra показывается как включённый в `:LazyExtras`, но не работает

**Решения**:

1. **Перезапустите Neovim** после включения extras

2. **Проверьте зависимости**:
   Некоторые extras требуют другие extras. Например:
   - `git.gitlab` требует `ui.diff-view`
   - `dap.vscode-js` требует `dap.core`

3. **Проверьте предупреждения**:
   ```vim
   :messages
   ```
   Ищите предупреждения "Missing extra"

4. **Проверьте загрузку extra**:
   ```lua
   :lua print(require("lazyvimx.util.general").has_extra("ui.winbar"))
   ```

### Группы буферов не появляются

**Симптомы**: Кастомные группы буферов не отображаются в bufferline

**Решения**:

1. **Включите override для bufferline**:
   ```lua
   { import = "lazyvimx.overrides.bufferline.add-groups" }
   ```
   Или включите через:
   ```lua
   { import = "lazyvimx.extras.core.overrides" }
   ```

2. **Проверьте конфигурацию**:
   ```vim
   :lua vim.print(require("lazyvimx").config.bufferline_groups)
   ```

3. **Протестируйте паттерн**:
   ```lua
   :lua print(vim.fn.expand("%"):match("%.tsx$"))
   ```
   Должно вернуть совпадение, если файл .tsx

4. **Проверьте установку bufferline**:
   ```vim
   :Lazy
   ```
   Найдите `akinsho/bufferline.nvim`

### Symbol usage не отображается

**Симптомы**: Счётчики ссылок не появляются

**Решения**:

1. **Проверьте работу LSP**:
   ```vim
   :LspInfo
   ```

2. **Проверьте включение extra**:
   ```vim
   :LazyExtras
   ```
   Найдите `ui.symbol-usage`

3. **Проверьте конфликты** с другими плагинами, изменяющими virtual text

4. **Перезапустите LSP**:
   ```vim
   :LspRestart
   ```

## Темы и цветовые схемы

### Тема не переключается автоматически

**Симптомы**: Цветовая схема не меняется с системной темой

**Решения**:

1. **Только для macOS**: Эта функция работает только на macOS

2. **Проверьте системную тему**:
   ```bash
   defaults read -g AppleInterfaceStyle
   ```
   Возвращает "Dark" в тёмном режиме, ошибку в светлом

3. **Включите override**:
   ```lua
   { import = "lazyvimx.overrides.lazyvim.auto-switch-colorscheme-on-signal" }
   ```
   Или через:
   ```lua
   { import = "lazyvimx.extras.core.overrides" }
   ```

4. **Проверьте событие Signal**: lazyvimx слушает autocmd `Signal`

5. **Ручной тест**:
   ```lua
   :lua vim.api.nvim_exec_autocmds("Signal", {})
   ```

### Неправильный вариант цветовой схемы

**Симптомы**: Всегда используется тёмный или светлый вариант

**Решения**:

1. **Проверьте конфиг flavors**:
   ```vim
   :lua vim.print(require("lazyvimx").config.colorscheme_flavors)
   ```

2. **Проверьте функцию flavor**:
   ```lua
   :lua print(require("lazyvimx.util.general").get_flavor())
   ```

3. **Проверьте определение темы**:
   ```lua
   :lua print(require("lazyvimx.util.general").theme_is_dark())
   ```

### Кастомная цветовая схема не работает

**Симптомы**: Кастомная тема не применяется

**Решения**:

1. **Убедитесь, что тема установлена**:
   ```lua
   {
     "author/my-theme",
     lazy = false,
     priority = 1000,
   }
   ```

2. **Настройте flavors**:
   ```lua
   require("lazyvimx").setup({
     colorscheme = "gruvbox",
     colorscheme_flavors = {
       gruvbox = { "gruvbox-dark", "gruvbox-light" },
     },
   })
   ```

3. **Примечание**: Кастомные темы не будут иметь настроек lazyvimx, если не создать overrides

## Проблемы производительности

### Медленный запуск

**Решения**:

1. **Профилируйте запуск**:
   ```bash
   nvim --startuptime startup.log
   sort -nk2 startup.log | tail -20
   ```

2. **Уменьшите количество extras**: Не используйте `core.all`, если не нужно всё
   ```lua
   -- Вместо
   { import = "lazyvimx.extras.core.all" }
   
   -- Используйте выборочный импорт
   { import = "lazyvimx.extras.core.overrides" },
   { import = "lazyvimx.extras.ui.better-diagnostic" },
   ```

3. **Проверьте количество плагинов**:
   ```vim
   :Lazy
   ```
   100+ плагинов могут замедлить запуск

4. **Включите ленивую загрузку**: Убедитесь, что плагины используют `lazy = true` или триггеры событий

### Высокое использование памяти

**Решения**:

1. **Включите очистку неактивных LSP**:
   ```lua
   { import = "lazyvimx.extras.perf.stop-inactive-lsp" }
   ```

2. **Включите очистку буферов**:
   ```lua
   { import = "lazyvimx.extras.buf.delete-inactive" }
   ```

3. **Проверьте использование памяти**:
   ```vim
   :lua print(collectgarbage("count"))
   ```

4. **Принудительная сборка мусора**:
   ```vim
   :lua collectgarbage()
   ```

### Лаги UI

**Решения**:

1. **Отключите анимации**:
   ```lua
   { import = "lazyvimx.overrides.snacks.disable-animation" }
   ```

2. **Уменьшите UI extras**:
   - Отключите `ui.scrollbar`
   - Отключите `ui.symbol-usage`
   - Отключите `ui.highlighted-colors`

3. **Проверьте производительность терминала**: Некоторые терминалы медленнее

4. **Уменьшите количество парсеров treesitter**:
   ```lua
   opts = {
     ensure_installed = { "lua", "vim", "vimdoc" }, -- Только нужные языки
   }
   ```

## Конфликты плагинов

### Конфликты горячих клавиш

**Симптомы**: Горячие клавиши не работают или запускают неправильные действия

**Решения**:

1. **Проверьте which-key**:
   ```vim
   :WhichKey
   ```

2. **Найдите конфликтующий маппинг**:
   ```vim
   :verbose map <leader>cr
   ```

3. **Переопределите в своём конфиге**:
   ```lua
   return {
     {
       "LazyVim/LazyVim",
       keys = {
         { "<leader>cr", false },  -- Отключить маппинг lazyvimx
         { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
       },
     },
   }
   ```

### Проблемы совместимости плагинов

**Симптомы**: Ошибки при использовании определённых плагинов вместе

**Решения**:

1. **Проверьте логи**:
   ```vim
   :Lazy log
   :messages
   ```

2. **Отключайте extras по одному** для поиска конфликта

3. **Проверьте требования плагинов**: Некоторым нужны определённые версии

4. **Сообщите о проблеме**: Если это баг lazyvimx, откройте issue на GitHub

## Проблемы LSP

### LSP не запускается

**Решения**:

1. **Проверьте статус LSP**:
   ```vim
   :LspInfo
   ```

2. **Проверьте Mason**:
   ```vim
   :Mason
   ```
   Убедитесь, что language server установлен

3. **Установите вручную**:
   ```vim
   :MasonInstall typescript-language-server
   ```

4. **Проверьте логи**:
   ```vim
   :LspLog
   ```

### Диагностика не отображается

**Решения**:

1. **Проверьте конфиг диагностики**:
   ```lua
   :lua vim.print(vim.diagnostic.config())
   ```

2. **Если используете better-diagnostic**: Проверьте включение extra
   ```vim
   :LazyExtras
   ```

3. **Переключите диагностику**:
   ```vim
   :lua vim.diagnostic.enable()
   ```

4. **Проверьте подключение LSP**:
   ```vim
   :LspInfo
   ```

### Переименование не работает

**Решения**:

1. **Проверьте включение live-rename**:
   ```vim
   :LazyExtras
   ```
   Найдите `ui.better-live-rename`

2. **Используйте стандартное переименование**:
   ```vim
   :lua vim.lsp.buf.rename()
   ```

3. **Проверьте поддержку rename в LSP**:
   ```lua
   :lua print(vim.lsp.get_active_clients()[1].server_capabilities.renameProvider)
   ```

## Проблемы с горячими клавишами

### Горячие клавиши не работают

**Решения**:

1. **Убедитесь, что импортирован extras.core.keys**:
   ```lua
   { import = "lazyvimx.extras.core.keys" }
   ```
   Или через `core.all`

2. **Проверьте режим VSCode**: Некоторые клавиши ведут себя по-другому в VSCode

3. **Проверьте существование маппинга**:
   ```vim
   :verbose nmap <leader>cr
   ```

4. **Проверьте leader key**:
   ```vim
   :echo mapleader
   ```
   По умолчанию должен быть пробел

### Русская клавиатура не работает

**Симптомы**: Vim motions не работают с русской раскладкой

**Решения**:

1. **Включите extra langmapper**:
   ```lua
   { import = "lazyvimx.extras.motions.langmapper" }
   ```

2. **Перезапустите Neovim** после включения

3. **Проверьте маппинг раскладки**:
   ```lua
   :lua print(require("langmapper").get_lang())
   ```

4. **Проверьте интеграцию which-key**: Должна работать автоматически

## Проблемы специфичные для macOS

### Определение системной темы не работает

**Решения**:

1. **Проверьте команду defaults**:
   ```bash
   defaults read -g AppleInterfaceStyle 2>&1
   ```

2. **Дайте права терминалу**: System Preferences → Security → Full Disk Access

3. **Протестируйте функцию темы**:
   ```lua
   :lua print(require("lazyvimx.util.general").theme_is_dark())
   ```

### Интеграция с корзиной не работает

**Решения**:

1. **Установите trash-cli**:
   ```bash
   brew install trash
   ```

2. **Проверьте команду trash**:
   ```bash
   which trash
   ```

3. **Fallback**: Будет использовать `rm`, если `trash` недоступен

### Синхронизация с chezmoi не работает

**Решения**:

1. **Проверьте переменную окружения**:
   ```bash
   echo $DOTFILES_SRC_PATH
   ```

2. **Установите в профиле shell**:
   ```bash
   # ~/.zshrc или ~/.bashrc
   export DOTFILES_SRC_PATH="$HOME/.local/share/chezmoi"
   ```

3. **Проверьте существование пути**:
   ```bash
   ls -la $DOTFILES_SRC_PATH
   ```

4. **Проверьте включение override**:
   ```lua
   { import = "lazyvimx.overrides.lazyvim.auto-apply-chezmoi-on-lazy-update" }
   ```

## Получение помощи

Если ни одно из этих решений не помогло:

1. **Проверьте FAQ**: [FAQ.ru.md](FAQ.ru.md)

2. **Поищите в issues**: [GitHub Issues](https://github.com/aimuzov/lazyvimx/issues)

3. **Спросите сообщество**: [Обсуждение в Telegram](https://t.me/aimuzov_dotfiles)

4. **Создайте issue**: Включите:
   - Версию Neovim (`:version`)
   - Версию lazyvimx (`:Lazy`)
   - Операционную систему
   - Минимальные шаги воспроизведения
   - Сообщения об ошибках (`:Lazy log`, `:messages`)
   - Соответствующую конфигурацию

5. **Предоставьте минимальную конфигурацию**:
   ```lua
   -- Минимальное воспроизведение
   local lazy_opts = {
     spec = {
       { "aimuzov/lazyvimx", import = "lazyvimx.boot" },
       { import = "lazyvimx.extras.core.all" },
     },
   }
   
   -- Bootstrap и setup
   -- ... (стандартный код bootstrap)
   ```

## Советы по отладке

### Включите подробное логирование

```lua
vim.o.verbose = 9
vim.o.verbosefile = vim.fn.stdpath("cache") .. "/vim.log"
```

### Проверьте загруженные модули

```vim
:lua vim.print(package.loaded)
```

### Проверьте спецификацию плагинов

```vim
:lua vim.print(require("lazy.core.config").spec.modules)
```

### Профилируйте плагины

```vim
:Lazy profile
```

### Проверьте autocmd

```vim
:autocmd Signal
:autocmd User LazyUpdate
```

---

**Всё ещё не работает?** Не стесняйтесь просить помощи. Сообщество здесь, чтобы помочь!
