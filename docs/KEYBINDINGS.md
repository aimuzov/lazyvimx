# Keyboard Shortcuts Reference

> [!TIP]
> **🇷🇺 Русская версия:** [KEYBINDINGS.ru.md](KEYBINDINGS.ru.md)

Complete reference for all lazyvimx custom keybindings.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Basic Operations](#basic-operations)
- [Files and Buffers](#files-and-buffers)
- [Navigation and Motions](#navigation-and-motions)
- [Window Management](#window-management)
- [LSP and Code](#lsp-and-code)
- [Git Operations](#git-operations)
- [GitLab Operations](#gitlab-operations)
- [DAP (Debugging)](#dap-debugging)
- [Full Reference](#full-reference)

## Prerequisites

All custom keybindings require:
```lua
{ import = "lazyvimx.extras.core.keys" }
```

Or include via:
```lua
{ import = "lazyvimx.extras.core.all" }
```

**Leader key**: Space (default LazyVim setting)

## Basic Operations

| Key              | Mode    | Description                      | Extra Required |
| ---------------- | ------- | -------------------------------- | -------------- |
| `d`              | n, v    | Delete without yanking           | core.keys      |
| `<C-S-j>`        | n, i, v | Move line/selection down         | core.keys      |
| `<C-S-k>`        | n, i, v | Move line/selection up           | core.keys      |
| `<leader>\`      | n       | Split window right               | core.keys      |
| `<leader>ch`     | n       | Open shell (cht.sh)              | core.keys      |
| `<leader>ll`     | n       | Open Lazy dashboard              | core.keys      |
| `<leader>lx`     | n       | Open Lazy extras                 | core.keys      |
| `<leader>uz`     | n       | Toggle zen mode                  | core.keys      |
| `<leader>uq`     | n       | Open dashboard                   | core.keys      |
| `<leader><tab>r` | n       | Rename tab                       | core.keys      |

## Files and Buffers

| Key               | Mode | Description                    | Extra Required     |
| ----------------- | ---- | ------------------------------ | ------------------ |
| `<leader><space>` | n    | Find files (smart)             | core.keys          |
| `<leader>fy`      | n    | Find files (yazi)              | ui.better-explorer |
| `<leader>fY`      | n    | Find files (yazi prev session) | ui.better-explorer |
| `<leader>bg`      | n, v | Pick buffer                    | core.keys          |
| `<leader>bm[`     | n    | Move buffer (prev)             | core.keys          |
| `<leader>bm]`     | n    | Move buffer (next)             | core.keys          |
| `<leader>b<tab>`  | n    | Move buffer to another tab     | buf.tab-scope      |
| `H`               | n    | Previous buffer                | core.keys          |
| `L`               | n    | Next buffer                    | core.keys          |

## Navigation and Motions

| Key       | Mode    | Description                     | Extra Required                   |
| --------- | ------- | ------------------------------- | -------------------------------- |
| `[x`      | n       | Go to treesitter context        | core.keys                        |
| `w`       | n, o, x | Move forward (spider)           | motions.better-move-between-words |
| `b`       | n, o, x | Move backward (spider)          | motions.better-move-between-words |
| `e`       | n, o, x | Move to end of word (spider)    | motions.better-move-between-words |
| `cw`      | n       | Change word (spider)            | motions.better-move-between-words |
| `<C-f>`   | i       | Move forward in insert (spider) | motions.better-move-between-words |
| `<C-b>`   | i       | Move backward in insert (spider)| motions.better-move-between-words |
| `<C-A-h>` | n       | TreeWalker left                 | motions.sibling-move             |
| `<C-A-l>` | n       | TreeWalker right                | motions.sibling-move             |
| `<C-A-j>` | n       | TreeWalker down                 | motions.sibling-move             |
| `<C-A-k>` | n       | TreeWalker up                   | motions.sibling-move             |
| `<C-A-.>` | n       | TreeWalker swap down            | motions.sibling-move             |
| `<C-A-,>` | n       | TreeWalker swap up              | motions.sibling-move             |

## Window Management

| Key         | Mode    | Description            | Extra Required |
| ----------- | ------- | ---------------------- | -------------- |
| `<C-Up>`    | n, v, t | Increase window height | core.keys      |
| `<C-Down>`  | n, v, t | Decrease window height | core.keys      |
| `<C-Left>`  | n, v, t | Decrease window width  | core.keys      |
| `<C-Right>` | n, v, t | Increase window width  | core.keys      |

## LSP and Code

| Key          | Mode | Description                  | Extra Required                    |
| ------------ | ---- | ---------------------------- | --------------------------------- |
| `gr`         | n    | Go to references (glance)    | ui.peek-preview                   |
| `<leader>cr` | n    | Rename (live-rename)         | ui.better-live-rename             |
| `<leader>cw` | n, v | Wrap with emmet abbreviation | coding.emmet                      |
| `<C-.>`      | n    | Swap sibling node right      | motions.sibling-swap              |
| `<C-,>`      | n    | Swap sibling node left       | motions.sibling-swap              |
| `<leader>ct` | n    | Split/Join block (autodetect)| motions.splitting-joining-blocks  |
| `<leader>c\` | n    | Split code block             | motions.splitting-joining-blocks  |
| `<leader>cj` | n    | Join code block              | motions.splitting-joining-blocks  |

## Git Operations

| Key           | Mode | Description                 | Extra Required |
| ------------- | ---- | --------------------------- | -------------- |
| `<leader>ghP` | n    | Preview hunk                | core.keys      |
| `go`          | n    | Open in browser (fugitive)  | git.fugitive   |
| `go`          | v    | Open range in browser       | git.fugitive   |
| `gx`          | n    | Open remote git repository  | git.remote-view|
| `gX`          | n    | Enter remote git repository | git.remote-view|

## GitLab Operations

**Requires**: `git.gitlab` extra

| Key           | Mode | Description                   |
| ------------- | ---- | ----------------------------- |
| `<leader>gLA` | n    | Approve MR                    |
| `<leader>gLc` | n    | Create comment                |
| `<leader>gLc` | v    | Create multiline comment      |
| `<leader>gLC` | v    | Create comment suggestion     |
| `<leader>gLd` | n    | Toggle discussion             |
| `<leader>gLe` | n    | Choose merge request          |
| `<leader>gLM` | n    | Merge MR                      |
| `<leader>gLm` | n    | Move to discussion tree       |
| `<leader>gLn` | n    | Create note                   |
| `<leader>gLo` | n    | Open in browser               |
| `<leader>gLp` | n    | Pipeline                      |
| `<leader>gLr` | n    | Review                        |
| `<leader>gLR` | n    | Revoke                        |
| `<leader>gLs` | n    | Summary                       |

## DAP (Debugging)

**Requires**: `dap.vscode-js` extra (or other DAP extras)

| Key     | Mode | Description |
| ------- | ---- | ----------- |
| `<F5>`  | n    | Continue    |
| `<F10>` | n    | Step over   |
| `<F11>` | n    | Step into   |
| `<F12>` | n    | Step out    |

## Full Reference

### Keybinding Modes

- `n` = Normal mode
- `v` = Visual mode
- `i` = Insert mode
- `o` = Operator-pending mode
- `x` = Visual and Select mode
- `t` = Terminal mode

### Source Code

All keybindings are defined in:
```
lua/lazyvimx/extras/core/keys.lua
```

View the complete source: [extras/core/keys.lua](../lua/lazyvimx/extras/core/keys.lua)

### Customizing Keybindings

#### Disable a Keybinding

```lua
-- lua/plugins/keys.lua
return {
  {
    "LazyVim/LazyVim",
    keys = {
      { "<leader>cr", false }, -- Disable lazyvimx rename
    },
  },
}
```

#### Override a Keybinding

```lua
-- lua/plugins/keys.lua
return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- Override with custom action
      { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename (default)" },
    },
  },
}
```

#### Add Custom Keybindings

```lua
-- lua/config/keymaps.lua
vim.keymap.set("n", "<leader>xx", "<cmd>MyCustomCommand<cr>", { desc = "My Custom Command" })
```

### Which-Key Integration

All keybindings are automatically integrated with which-key. To view them:

```vim
:WhichKey
```

Or specific prefix:

```vim
:WhichKey <leader>g
```

### Russian Keyboard Support

For Russian keyboard layout support, enable:
```lua
{ import = "lazyvimx.extras.motions.langmapper" }
```

This allows using Vim motions without switching keyboard layout.

### Conflicting Keybindings

If you experience conflicts:

1. **Check which keybinding is active**:
   ```vim
   :verbose map <leader>cr
   ```

2. **See all mappings for a key**:
   ```vim
   :map <leader>cr
   ```

3. **Disable conflicting plugin**: In your config, disable the conflicting extra or plugin

### Tips

1. **Use which-key**: Press leader key and wait to see available keybindings
2. **Learn incrementally**: Don't try to memorize all at once
3. **Start with basics**: Basic operations and file/buffer management
4. **Practice motions**: Spider motions and TreeWalker significantly improve navigation
5. **Customize**: Don't hesitate to change keybindings to match your workflow

## See Also

- [LazyVim Keybindings](https://www.lazyvim.org/keymaps) - Base LazyVim keybindings
- [CONFIGURATION.md](CONFIGURATION.md) - Configuration guide
- [EXTRAS.md](EXTRAS.md) - All extras documentation
- [FAQ.md](FAQ.md#keybinding-problems) - Keybinding troubleshooting
