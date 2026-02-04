# Часто Задаваемые Вопросы (FAQ)

> [!TIP]
> **🇬🇧 English version:** [FAQ.md](FAQ.md)

Популярные вопросы и ответы о lazyvimx.

## Оглавление

- [Общие вопросы](#общие-вопросы)
- [Установка](#установка)
- [Конфигурация](#конфигурация)
- [Extras](#extras)
- [Решение проблем](#решение-проблем)
- [Производительность](#производительность)
- [Интеграция](#интеграция)

## Общие вопросы

### Что такое lazyvimx?

lazyvimx — это слой улучшений для [LazyVim](https://github.com/LazyVim/LazyVim), который предоставляет 48 опциональных расширений (extras) и 33 модуля переопределений (overrides). Проект создан для получения максимально отполированного и функционального Neovim, сохраняя совместимость с LazyVim.

### Чем lazyvimx отличается от LazyVim?

lazyvimx **расширяет** LazyVim, а не заменяет его:
- **LazyVim**: Фундамент - надёжная, продуманная конфигурация Neovim
- **lazyvimx**: Опциональные улучшения - UI-enhancements, оптимизация workflow, дополнительные функции

Вы можете использовать lazyvimx с LazyVim и при этом настраивать всё под себя.

### Можно ли использовать lazyvimx без LazyVim?

Нет, lazyvimx построен поверх LazyVim и требует его в качестве зависимости. LazyVim предоставляет основу, а lazyvimx её улучшает.

### Стабилен ли lazyvimx?

Да. lazyvimx следует семантическому версионированию (текущая: v1.5.0) и поддерживает обратную совместимость. Все extras опциональны, так что вы полностью контролируете, что включать.

### Как обновить lazyvimx?

lazyvimx обновляется автоматически вместе с плагинами LazyVim:

```vim
:Lazy update
```

Проверьте [CHANGELOG.md](../CHANGELOG.md) для изменений в конкретных версиях.

## Установка

### Какие минимальные требования?

- **Neovim** >= 0.10.0
- **LazyVim** (устанавливается автоматически)
- **Git** (для управления плагинами)

### Как установить lazyvimx?

См. [Быстрый старт](../README.ru.md#быстрый-старт) в README. Вкратце:

1. Создайте `~/.config/nvim/init.lua` с импортом lazyvimx boot
2. Запустите Neovim
3. Всё установится автоматически!

### Могу ли я мигрировать с LazyVim на lazyvimx?

Да! lazyvimx совместим с существующими конфигурациями LazyVim:

1. Сделайте бэкап: `cp -r ~/.config/nvim ~/.config/nvim.backup`
2. Обновите `init.lua`, добавив импорт lazyvimx boot
3. Перезапустите Neovim
4. Ваши существующие плагины и конфигурация продолжат работать

### Куда добавлять свои плагины?

Туда же, куда и в LazyVim - в `~/.config/nvim/lua/plugins/`:

```lua
-- ~/.config/nvim/lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  opts = {},
}
```

## Конфигурация

### Как настроить lazyvimx?

Используйте функцию `setup()`:

```lua
-- ~/.config/nvim/lua/config/lazyvimx.lua или в спецификации плагина
require("lazyvimx").setup({
  colorscheme = "catppuccin",
  colorscheme_flavors = {
    catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
  },
  bufferline_groups = {
    ["React"] = "%.tsx$",
  },
})
```

См. [CONFIGURATION.ru.md](CONFIGURATION.ru.md) для всех опций.

### Как изменить цветовую схему?

Два способа:

**Вариант 1**: Настроить в setup (рекомендуется)
```lua
require("lazyvimx").setup({
  colorscheme = "tokyonight",
})
```

**Вариант 2**: Установить напрямую
```vim
:colorscheme tokyonight-storm
```

### Как работает автопереключение темы?

На macOS lazyvimx определяет системный светлый/тёмный режим и переключается автоматически:

```lua
colorscheme_flavors = {
  catppuccin = {
    "catppuccin-macchiato",  -- Тёмный режим
    "catppuccin-latte",      -- Светлый режим
  },
}
```

Требуется включить `extras.core.overrides`.

### Можно ли отключить конкретные overrides?

Да, вместо импорта `core.overrides` импортируйте категории вручную:

```lua
{ import = "lazyvimx.overrides.lazyvim" },   -- Оставить
{ import = "lazyvimx.overrides.snacks" },     -- Оставить
-- { import = "lazyvimx.overrides.bufferline" },  -- Пропустить
{ import = "lazyvimx.overrides.other" },      -- Оставить
```

## Extras

### Что такое extras?

Extras — это опциональные модули функций, которые улучшают возможности. Примеры:
- `ui.better-diagnostic` - Inline сообщения диагностики
- `motions.langmapper` - Поддержка русской клавиатуры
- `git.gitlab` - Интеграция GitLab MR

См. [EXTRAS.ru.md](EXTRAS.ru.md) для всех 48 extras.

### Как включить extras?

**Через UI** (рекомендуется):
```vim
:LazyExtras
```
Найдите секцию lazyvimx `[ 󰬟 ]`, выберите extras с помощью `x`, перезапустите.

**Через конфиг**:
```lua
{ import = "lazyvimx.extras.ui.better-diagnostic" },
{ import = "lazyvimx.extras.motions.langmapper" },
```

**Включить всё**:
```lua
{ import = "lazyvimx.extras.core.all" },
```

### Можно ли создавать свои extras?

Да! См. [CONTRIBUTING.md](../CONTRIBUTING.md#creating-extras) для руководства по созданию кастомных extras.

### Нужно ли включать все extras?

Нет! Extras полностью опциональны. Включайте только то, что нужно:
- Минимальная настройка: Только `core.overrides`
- Рекомендуемая: `core.all` (включает все extras)
- Кастомная: Выберите отдельные extras

### Какие extras рекомендуется включить?

Рекомендуемый стартовый набор:
- `core.overrides` - Все улучшения плагинов
- `ui.better-diagnostic` - Улучшенное отображение ошибок
- `ui.better-float` - Единообразный UI
- `motions.langmapper` - Если используете русскую клавиатуру
- `git.conflicts` - Если используете Git

## Решение проблем

### lazyvimx extras не отображаются в :LazyExtras

Убедитесь, что импортирован модуль boot:

```lua
{ "aimuzov/lazyvimx", import = "lazyvimx.boot" }
```

### Тема не переключается автоматически

Проверьте:
1. Функция только для macOS - не работает на Linux/Windows
2. Проверьте системную тему: `defaults read -g AppleInterfaceStyle`
3. Включите override: `{ import = "lazyvimx.extras.core.overrides" }`

### Группы буферов не работают

Включите override:
```lua
{ import = "lazyvimx.overrides.bufferline.add-groups" }
```

Или через core overrides:
```lua
{ import = "lazyvimx.extras.core.overrides" }
```

### Плагины не загружаются

Проверьте логи:
```vim
:Lazy log
```

Частые проблемы:
- Устаревшая версия Neovim (требуется >= 0.10.0)
- Конфликты плагинов - отключите конфликтующие плагины
- Недостающие зависимости - установите через `:Lazy install`

### Как сообщить о баге?

1. Проверьте [существующие issues](https://github.com/aimuzov/lazyvimx/issues)
2. Попробуйте минимальную конфигурацию (отключите кастомные плагины)
3. Создайте новый issue с:
   - Версией Neovim (`:version`)
   - Версией lazyvimx (`:Lazy`)
   - Шагами воспроизведения
   - Сообщениями об ошибках из `:Lazy log`

См. [TROUBLESHOOTING.ru.md](TROUBLESHOOTING.ru.md) для дополнительных решений.

## Производительность

### lazyvimx медленный?

Нет. lazyvimx активно использует ленивую загрузку:
- Extras загружаются только при импорте
- Плагины используют `optional = true` для graceful degradation
- Нет влияния, если extras не включены

### Как улучшить производительность?

1. **Включайте только нужные extras** - Не используйте `core.all`, если не нужно всё
2. **Используйте perf extras**:
   - `perf.local-config` - Конфигурация для конкретных проектов
   - `perf.stop-inactive-lsp` - Очистка неиспользуемых LSP клиентов
3. **Проверьте время запуска**: `nvim --startuptime startup.log`
4. **Профилирование**: `:Lazy profile`

### Замедляет ли lazyvimx запуск Neovim?

Минимальное влияние. Boot модуль и setup легковесны. Extras загружаются только при явном импорте.

Бенчмарк (холодный старт):
- LazyVim отдельно: ~50-80ms
- LazyVim + lazyvimx (минимальный): ~55-85ms (+5ms)
- LazyVim + lazyvimx (core.all): ~80-120ms (+30-40ms)

## Интеграция

### Работает ли lazyvimx с VSCode Neovim?

Да! Есть специальная интеграция:

```lua
{ import = "lazyvimx.overrides.lazyvim.vscode" }
```

Включена в `core.overrides`. Возможности:
- Синхронизация индикатора режима
- Адаптированные горячие клавиши
- Нативная интеграция переименования VSCode

### Можно ли использовать lazyvimx с chezmoi?

Да! Автосинхронизация встроена:

```bash
export DOTFILES_SRC_PATH="$HOME/.local/share/chezmoi"
```

Автоматически синхронизирует `lazy-lock.json` и `lazyvim.json` при обновлениях.

### Работает ли на Linux/Windows?

Да, lazyvimx работает на всех платформах. Некоторые функции специфичны для macOS:
- Автопереключение темы (только macOS)
- Интеграция с корзиной для neo-tree (предпочтительно macOS, но работает везде)

### Можно ли использовать кастомные цветовые схемы?

Да:

```lua
require("lazyvimx").setup({
  colorscheme = "gruvbox",
  colorscheme_flavors = {
    gruvbox = { "gruvbox-dark", "gruvbox-light" },
  },
})
```

Примечание: Кастомные темы не будут иметь настроек темы lazyvimx, если вы не создадите модули переопределений.

## Остались вопросы?

- 📖 Читайте [полную документацию](../docs/)
- 💬 Присоединяйтесь к [обсуждению](https://t.me/aimuzov_dotfiles)
- 🐛 [Сообщите о проблеме](https://github.com/aimuzov/lazyvimx/issues)
- 🤝 [Внесите вклад](../CONTRIBUTING.md)
