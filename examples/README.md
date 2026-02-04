# Примеры конфигураций lazyvimx

Готовые конфигурации для различных сценариев использования.

## Доступные примеры

### [Minimal](minimal/)
Минимальная настройка с только переопределениями плагинов.
- **Подходит для**: Пользователей, которые хотят контроль и будут добавлять extras индивидуально
- **Запуск**: ~55-85ms
- **Плагины**: ~60-70

### [Full-Featured](full-featured/)
Полный lazyvimx со всеми 48 extras включёнными.
- **Подходит для**: Пользователей, которые хотят всё из коробки
- **Запуск**: ~80-120ms
- **Плагины**: ~100-120

### [VSCode User](vscode-user/)
Оптимизирован для расширения VSCode Neovim.
- **Подходит для**: Пользователей VSCode, которые хотят Vim motions
- **Запуск**: Очень быстрый
- **Плагины**: Минимум (только улучшения движений)

### [Russian Keyboard](russian-keyboard/)
Поддержка русской раскладки клавиатуры с langmapper.
- **Подходит для**: Русскоязычных пользователей
- **Запуск**: ~70-100ms
- **Плагины**: ~80-90

## Как использовать

1. Выберите пример, который подходит вашему сценарию
2. Скопируйте `init.lua` из этой директории в `~/.config/nvim/init.lua`
3. Запустите Neovim
4. Настройте при необходимости

## Кастомизация

Все примеры можно настроить:

### Добавить свои плагины

Создайте `~/.config/nvim/lua/plugins/my-plugin.lua`:

```lua
return {
  "author/plugin-name",
  opts = {},
}
```

### Включить больше Extras

Через UI:
```vim
:LazyExtras
```

Или в конфиге:
```lua
{ import = "lazyvimx.extras.ui.winbar" },
{ import = "lazyvimx.extras.git.gitlab" },
```

### Настроить lazyvimx

Создайте `~/.config/nvim/lua/plugins/lazyvimx.lua`:

```lua
return {
  "aimuzov/lazyvimx",
  opts = {
    colorscheme = "tokyonight",
    bufferline_groups = {
      ["Tests"] = "%.test%.",
    },
  },
}
```

## Нужна помощь?

- [Руководство по настройке](../docs/CONFIGURATION.ru.md)
- [Справочник Extras](../docs/EXTRAS.ru.md)
- [FAQ](../docs/FAQ.ru.md)
- [Решение проблем](../docs/TROUBLESHOOTING.ru.md)
