# Справочник горячих клавиш

> [!TIP]
> **🇬🇧 English version:** [KEYBINDINGS.md](KEYBINDINGS.md)

Полный справочник всех кастомных горячих клавиш lazyvimx.

## Оглавление

- [Предварительные требования](#предварительные-требования)
- [Базовые операции](#базовые-операции)
- [Файлы и буферы](#файлы-и-буферы)
- [Навигация и движения](#навигация-и-движения)
- [Управление окнами](#управление-окнами)
- [LSP и код](#lsp-и-код)
- [Git операции](#git-операции)
- [GitLab операции](#gitlab-операции)
- [DAP (Отладка)](#dap-отладка)
- [Полный справочник](#полный-справочник)

## Предварительные требования

Все кастомные горячие клавиши требуют:
```lua
{ import = "lazyvimx.extras.core.keys" }
```

Или включите через:
```lua
{ import = "lazyvimx.extras.core.all" }
```

**Leader key**: Пробел (стандартная настройка LazyVim)

## Базовые операции

| Клавиша          | Режим   | Описание                         | Требуемый Extra |
| ---------------- | ------- | -------------------------------- | --------------- |
| `d`              | n, v    | Удалить без копирования          | core.keys       |
| `<C-S-j>`        | n, i, v | Переместить строку/выделение вниз| core.keys       |
| `<C-S-k>`        | n, i, v | Переместить строку/выделение вверх| core.keys      |
| `<leader>\`      | n       | Разделить окно вправо            | core.keys       |
| `<leader>ch`     | n       | Открыть shell (cht.sh)           | core.keys       |
| `<leader>ll`     | n       | Открыть Lazy dashboard           | core.keys       |
| `<leader>lx`     | n       | Открыть Lazy extras              | core.keys       |
| `<leader>uz`     | n       | Переключить zen режим            | core.keys       |
| `<leader>uq`     | n       | Открыть dashboard                | core.keys       |
| `<leader><tab>r` | n       | Переименовать таб                | core.keys       |

## Файлы и буферы

| Клавиша           | Режим | Описание                        | Требуемый Extra    |
| ----------------- | ----- | ------------------------------- | ------------------ |
| `<leader><space>` | n     | Найти файлы (smart)             | core.keys          |
| `<leader>fy`      | n     | Найти файлы (yazi)              | ui.better-explorer |
| `<leader>fY`      | n     | Найти файлы (yazi prev session) | ui.better-explorer |
| `<leader>bg`      | n, v  | Выбрать буфер                   | core.keys          |
| `<leader>bm[`     | n     | Переместить буфер (prev)        | core.keys          |
| `<leader>bm]`     | n     | Переместить буфер (next)        | core.keys          |
| `<leader>b<tab>`  | n     | Переместить буфер в другой таб  | buf.tab-scope      |
| `H`               | n     | Предыдущий буфер                | core.keys          |
| `L`               | n     | Следующий буфер                 | core.keys          |

## Навигация и движения

| Клавиша   | Режим   | Описание                        | Требуемый Extra                   |
| --------- | ------- | ------------------------------- | --------------------------------- |
| `[x`      | n       | Перейти к контексту treesitter  | core.keys                         |
| `w`       | n, o, x | Движение вперёд (spider)        | motions.better-move-between-words |
| `b`       | n, o, x | Движение назад (spider)         | motions.better-move-between-words |
| `e`       | n, o, x | К концу слова (spider)          | motions.better-move-between-words |
| `cw`      | n       | Изменить слово (spider)         | motions.better-move-between-words |
| `<C-f>`   | i       | Вперёд в insert (spider)        | motions.better-move-between-words |
| `<C-b>`   | i       | Назад в insert (spider)         | motions.better-move-between-words |
| `<C-A-h>` | n       | TreeWalker влево                | motions.sibling-move              |
| `<C-A-l>` | n       | TreeWalker вправо               | motions.sibling-move              |
| `<C-A-j>` | n       | TreeWalker вниз                 | motions.sibling-move              |
| `<C-A-k>` | n       | TreeWalker вверх                | motions.sibling-move              |
| `<C-A-.>` | n       | TreeWalker поменять вниз        | motions.sibling-move              |
| `<C-A-,>` | n       | TreeWalker поменять вверх       | motions.sibling-move              |

## Управление окнами

| Клавиша     | Режим   | Описание              | Требуемый Extra |
| ----------- | ------- | --------------------- | --------------- |
| `<C-Up>`    | n, v, t | Увеличить высоту окна | core.keys       |
| `<C-Down>`  | n, v, t | Уменьшить высоту окна | core.keys       |
| `<C-Left>`  | n, v, t | Уменьшить ширину окна | core.keys       |
| `<C-Right>` | n, v, t | Увеличить ширину окна | core.keys       |

## LSP и код

| Клавиша      | Режим | Описание                          | Требуемый Extra                  |
| ------------ | ----- | --------------------------------- | -------------------------------- |
| `gr`         | n     | Перейти к ссылкам (glance)        | ui.peek-preview                  |
| `<leader>cr` | n     | Переименовать (live-rename)       | ui.better-live-rename            |
| `<leader>cw` | n, v  | Обернуть emmet abbreviation       | coding.emmet                     |
| `<C-.>`      | n     | Поменять sibling узел вправо      | motions.sibling-swap             |
| `<C-,>`      | n     | Поменять sibling узел влево       | motions.sibling-swap             |
| `<leader>ct` | n     | Split/Join блок (автоопределение) | motions.splitting-joining-blocks |
| `<leader>c\` | n     | Split блок кода                   | motions.splitting-joining-blocks |
| `<leader>cj` | n     | Join блок кода                    | motions.splitting-joining-blocks |

## Git операции

| Клавиша       | Режим | Описание                          | Требуемый Extra |
| ------------- | ----- | --------------------------------- | --------------- |
| `<leader>ghP` | n     | Предпросмотр hunk                 | core.keys       |
| `go`          | n     | Открыть в браузере (fugitive)     | git.fugitive    |
| `go`          | v     | Открыть диапазон в браузере       | git.fugitive    |
| `gx`          | n     | Открыть удалённый git репозиторий | git.remote-view |
| `gX`          | n     | Войти в удалённый git репозиторий | git.remote-view |

## GitLab операции

**Требуется**: extra `git.gitlab`

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

## DAP (Отладка)

**Требуется**: extra `dap.vscode-js` (или другие DAP extras)

| Клавиша | Режим | Описание              |
| ------- | ----- | --------------------- |
| `<F5>`  | n     | Продолжить            |
| `<F10>` | n     | Шаг через (step over) |
| `<F11>` | n     | Шаг в (step into)     |
| `<F12>` | n     | Шаг из (step out)     |

## Полный справочник

### Режимы горячих клавиш

- `n` = Normal режим
- `v` = Visual режим
- `i` = Insert режим
- `o` = Operator-pending режим
- `x` = Visual и Select режим
- `t` = Terminal режим

### Исходный код

Все горячие клавиши определены в:
```
lua/lazyvimx/extras/core/keys.lua
```

Посмотрите полный исходник: [extras/core/keys.lua](../lua/lazyvimx/extras/core/keys.lua)

### Настройка горячих клавиш

#### Отключить горячую клавишу

```lua
-- lua/plugins/keys.lua
return {
  {
    "LazyVim/LazyVim",
    keys = {
      { "<leader>cr", false }, -- Отключить rename lazyvimx
    },
  },
}
```

#### Переопределить горячую клавишу

```lua
-- lua/plugins/keys.lua
return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- Переопределить кастомным действием
      { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename (default)" },
    },
  },
}
```

#### Добавить кастомные горячие клавиши

```lua
-- lua/config/keymaps.lua
vim.keymap.set("n", "<leader>xx", "<cmd>MyCustomCommand<cr>", { desc = "My Custom Command" })
```

### Интеграция с Which-Key

Все горячие клавиши автоматически интегрированы с which-key. Чтобы посмотреть их:

```vim
:WhichKey
```

Или для конкретного префикса:

```vim
:WhichKey <leader>g
```

### Поддержка русской клавиатуры

Для поддержки русской раскладки клавиатуры включите:
```lua
{ import = "lazyvimx.extras.motions.langmapper" }
```

Это позволит использовать Vim motions без переключения с русской раскладки.

### Конфликтующие горячие клавиши

Если вы столкнулись с конфликтами:

1. **Проверьте, какая горячая клавиша активна**:
   ```vim
   :verbose map <leader>cr
   ```

2. **Посмотрите все маппинги для клавиши**:
   ```vim
   :map <leader>cr
   ```

3. **Отключите конфликтующий плагин**: В вашем конфиге отключите конфликтующий extra или плагин

### Советы

1. **Используйте which-key**: Нажмите leader и подождите, чтобы увидеть доступные горячие клавиши
2. **Учите постепенно**: Не пытайтесь запомнить всё сразу
3. **Начните с базовых**: Базовые операции и управление файлами/буферами
4. **Практикуйте движения**: Spider motions и TreeWalker значительно улучшают навигацию
5. **Настраивайте**: Не стесняйтесь менять горячие клавиши под свой workflow

## См. также

- [Горячие клавиши LazyVim](https://www.lazyvim.org/keymaps) - Базовые горячие клавиши LazyVim
- [CONFIGURATION.ru.md](CONFIGURATION.ru.md) - Руководство по настройке
- [EXTRAS.ru.md](EXTRAS.ru.md) - Документация по всем extras
- [FAQ.ru.md](FAQ.ru.md#проблемы-с-горячими-клавишами) - Решение проблем с горячими клавишами
