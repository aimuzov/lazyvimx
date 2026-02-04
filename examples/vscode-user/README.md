# Конфигурация lazyvimx для VSCode

Конфигурация lazyvimx, оптимизированная для пользователей расширения VSCode Neovim.

## Что включено

- ✅ Базовый LazyVim
- ✅ Основные переопределения lazyvimx (включая интеграцию с VSCode)
- ✅ Улучшения движений (отлично работают в VSCode)
- ✅ Инструменты разработки
- ❌ UI extras (VSCode предоставляет UI)
- ❌ LSP extras (используйте LSP VSCode)

## Возможности

### Интеграция с VSCode
- Синхронизация индикатора режима со статус-баром VSCode
- Адаптированные горячие клавиши для VSCode
- Нативная интеграция переименования VSCode

### Улучшенные движения
- **Spider**: Subword-aware w/b/e движения
- **Sibling Swap**: Перестановка параметров функции с `<C-,>` / `<C-.>`
- **TreeWalker**: Навигация по AST с `<C-A-hjkl>`
- **Block Split/Join**: Умная манипуляция блоками кода

### Инструменты разработки
- Улучшенное комментирование с tree-sitter
- Генерация JSDoc

## Установка

1. Установите [расширение VSCode Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)

2. Скопируйте `init.lua` в `~/.config/nvim/init.lua`

3. В settings.json VSCode:
   ```json
   {
     "vscode-neovim.neovimExecutablePaths.darwin": "/opt/homebrew/bin/nvim",
     "vscode-neovim.neovimInitVimPaths.darwin": "~/.config/nvim/init.lua"
   }
   ```

4. Перезапустите VSCode

## Рекомендуемые расширения VSCode

- **nvim-mode-indicator**: Показывает режим Neovim в статус-баре
- **GitLens**: Интеграция с Git (вместо git extras lazyvimx)
- **Error Lens**: Inline диагностика (аналог better-diagnostic)

## Что НЕ включать

Избегайте этих extras в VSCode:

- UI extras (bufferline, lualine и т.д.) - VSCode предоставляет UI
- LSP extras - Используйте LSP VSCode
- Explorer extras - Используйте файловый менеджер VSCode
- DAP extras - Используйте отладчик VSCode

## Горячие клавиши

Все горячие клавиши движений отлично работают в VSCode:

- `w` / `b` / `e` - Умные движения
- `<C-.>` / `<C-,>` - Перестановка соседних элементов
- `<C-A-hjkl>` - Навигация TreeWalker
- `<leader>ct` - Разделить/объединить блоки

## Производительность

- **Запуск**: Очень быстрый (минимум плагинов)
- **Без конфликтов**: Работает вместе с функциями VSCode
