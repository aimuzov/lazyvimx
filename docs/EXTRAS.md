# Extras Guide

> [!TIP]
> **🇷🇺 Русская версия:** [EXTRAS.ru.md](EXTRAS.ru.md)

Complete guide to all 49 lazyvimx extras modules.

## Table of Contents

- [Overview](#overview)
- [Core Extras](#core-extras)
- [UI Extras (20)](#ui-extras)
- [Coding Extras (2)](#coding-extras)
- [Motion Extras (6)](#motion-extras)
- [Buffer Extras (3)](#buffer-extras)
- [Git Extras (4)](#git-extras)
- [Language Extras (2)](#language-extras)
- [Linting Extras (2)](#linting-extras)
- [AI Extras (1)](#ai-extras)
- [DAP Extras (1)](#dap-extras)
- [Performance Extras (4)](#performance-extras)
- [Test Extras (1)](#test-extras)

## Overview

Extras are optional feature modules that enhance LazyVim functionality. All extras are completely optional and can be enabled individually via `:LazyExtras` UI or by importing them in your configuration.

### Enabling Extras

**Via UI:**

```vim
:LazyExtras
```

**Via Configuration:**

```lua
{ import = "lazyvimx.extras.category.extra-name" }
```

**Enable All:**

```lua
{ import = "lazyvimx.extras.core.all" }
```

---

## Core Extras

Core extras provide orchestration and fundamental enhancements.

### core.all

**Import:** `lazyvimx.extras.core.all`

Complete lazyvimx experience with all features enabled.

**Includes:**

- All overrides
- All extras
- Custom keybindings
- Recommended extras notifications

**Usage:**

```lua
{ import = "lazyvimx.extras.core.all" }
```

**Notifications:**
Checks for recommended LazyVim extras:

- `coding.mini-surround`
- `coding.yanky`
- `ui.edgy`
- `ui.treesitter-context`

### core.overrides

**Import:** `lazyvimx.extras.core.overrides`

**Recommended:** Yes

All plugin overrides (33 modules across 4 categories).

**Includes:**

- LazyVim core overrides (8 modules)
- Snacks.nvim overrides (7 modules)
- Bufferline overrides (6 modules)
- Other plugin overrides (13 modules)

See [ARCHITECTURE.md](./ARCHITECTURE.md#overrides-system) for details.

### core.extras

**Import:** `lazyvimx.extras.core.extras`

Registry of all 43 extras. Use this to enable all features at once.

### core.keys

**Import:** `lazyvimx.extras.core.keys`

Custom keybindings for lazyvimx features.

**Key Highlights:**

- `d` - Delete without yanking
- `<C-S-j/k>` - Move lines up/down
- `<leader>\` - Split window right
- `<F5-F12>` - DAP debugging
- `<C-,/.>` - Sibling swap
- `gr` - Go to references (glance)
- `<leader>cr` - Rename (live-rename)

See [README.md#key-mappings](./README.md#key-mappings) for complete list.

---

## UI Extras

UI extras enhance the visual experience and interface.

### ui.better-diagnostic

**Import:** `lazyvimx.extras.ui.better-diagnostic`

Inline diagnostic messages displayed at cursor position with icons and colors.

**Features:**

- Single-line diagnostic display
- Custom arrow icons (→, ↓, ←, ↑)
- Vertical bar separators
- High priority (5000) virtual text
- Disables native virtual text

**Plugin:** `rachartier/tiny-inline-diagnostic.nvim`

**Screenshot Features:**

```
function foo() {
  return bar  → Undefined variable 'bar'
}
```

### ui.better-insert-mode

**Import:** `lazyvimx.extras.ui.better-insert-mode`

Automatically hides distracting UI elements during insert mode.

**Hides:**

- Treesitter context
- Symbol usage indicators
- Indent guides
- Virtual column

**Benefits:**

- Cleaner editing experience
- Less visual clutter
- Better focus

### ui.better-linenumbers

**Import:** `lazyvimx.extras.ui.better-linenumbers`

Smart line number display based on context.

**Features:**

- Disables relative numbers in command-line mode
- Disables all numbers in terminal buffers
- Automatic restoration

### ui.highlighted-ansi-escape

**Import:** `lazyvimx.extras.ui.highlighted-ansi-escape`

Renders ANSI escape sequences with proper colors.

**Features:**

- `:BaleiaColorize` - Colorize current buffer
- `:BaleiaLogs` - Show logger
- Auto-colorize DAP REPL output

**Plugin:** `m00qek/baleia.nvim`

**Use Cases:**

- Viewing logs with colors
- DAP REPL output
- Terminal output in buffers

### ui.highlighted-colors

**Import:** `lazyvimx.extras.ui.highlighted-colors`

Visual color code indicators in files.

**Features:**

- Highlights hex colors (#RRGGBB)
- Virtual icon display (󱓻)
- End-of-line placement
- Automatic color detection

**Plugin:** `brenoprata10/nvim-highlight-colors`

**Example:**

```css
background: #FF5733;  󱓻
color: #3498DB;       󱓻
```

### ui.symbol-usage

**Import:** `lazyvimx.extras.ui.symbol-usage`

JetBrains-like reference counters for symbols.

**Features:**

- Shows references (󰌹)
- Shows definitions (󰳽)
- Shows implementations (󰡱)
- End-of-line display
- Stacked function counter

**Plugin:** `Wansmer/symbol-usage.nvim`

**Example:**

```typescript
function calculate() {  󰌹 3 refs  󰳽 1 def
  // ...
}
```

### ui.diff-view

**Import:** `lazyvimx.extras.ui.diff-view`

Enhanced diff view with consistent panel sizing.

**Features:**

- File panel on left (width from layout utility)
- History panel at bottom (height from layout utility)
- Consistent sizing with other sidebars

**Plugin:** `sindrets/diffview.nvim`

**Commands:**

- `:DiffviewOpen` - Open diff view
- `:DiffviewFileHistory` - File history

### ui.better-live-rename

**Import:** `lazyvimx.extras.ui.better-live-rename`

Live preview of LSP rename operations.

**Features:**

- Inline editing with preview
- Submit with Enter (n/v/i modes)
- Cancel with Ctrl+C

**Plugin:** `saecki/live-rename.nvim`

**Keybinding:** `<leader>cr` - Rename (via core.keys)

### ui.better-reference-highlight

**Import:** `lazyvimx.extras.ui.better-reference-highlight`

Enhanced LSP reference highlighting with better visibility.

**Features:**

- Bold foreground highlighting instead of background
- Distinct colors for read/write references
- Works with Catppuccin (rosewater color)
- Works with Tokyo Night (magenta blend)
- No background clutter

**Highlights:**

- `LspReferenceRead` - Bold rosewater/magenta
- `LspReferenceText` - Bold rosewater/magenta
- `LspReferenceWrite` - Bold rosewater/magenta with underline (Tokyo Night)

**Themes:** Catppuccin, Tokyo Night (overrides theme defaults)

### ui.better-explorer

**Import:** `lazyvimx.extras.ui.better-explorer`

Yazi file manager integration as primary explorer.

**Features:**

- Full-window floating UI
- No borders
- Fast navigation
- Rich file previews
- Integration with neo-tree

**Plugin:** `mikavilpas/yazi.nvim`

**Keybinding:** `<leader>fy` (via core.keys)

### ui.simple-mode

**Import:** `lazyvimx.extras.ui.simple-mode`

Minimal UI mode for viewing (e.g., man pages).

**Features:**

- Detects `+Man!` argument
- Disables statusline, bufferline, neo-tree
- Removes line numbers
- Clean viewing experience

**Triggered By:**

```bash
nvim +Man! some-command
```

### ui.better-colorcolumn

**Import:** `lazyvimx.extras.ui.better-colorcolumn`

Virtual column indicator at 120 characters.

**Features:**

- Vertical bar character (│)
- Snacks indent integration
- Excluded filetypes: dashboard

**Plugin:** `lukas-reineke/virt-column.nvim`

### ui.scrollbar

**Import:** `lazyvimx.extras.ui.scrollbar`

Visual scrollbar in current window.

**Features:**

- Current window only
- Excludes special filetypes
- Hidden during insert mode
- Right-aligned indicators

**Plugin:** `dstein64/nvim-scrollview`

### ui.winbar

**Import:** `lazyvimx.extras.ui.winbar`

Window bar with file name and icon.

**Features:**

- Filetype icon
- Pretty path display
- Bold formatting
- Transparent background
- Disabled for special buffers

**Plugin:** `nvim-lualine/lualine.nvim`

### ui.bolder-separators

**Import:** `lazyvimx.extras.ui.bolder-separators`

Heavy Unicode window separators.

**Characters:**

- Horizontal: ━
- Vertical: ┃
- Intersections: ┳, ┻, ╋, ┫, ┣

**Visual Impact:**
More prominent window divisions.

### ui.better-cursorline

**Import:** `lazyvimx.extras.ui.better-cursorline`

Smart cursorline that follows active window.

**Features:**

- Enabled in insert mode
- Always highlights line number
- Excludes special filetypes
- Window-aware

**Plugin:** `tummetott/reticle.nvim`

### ui.better-whitespace

**Import:** `lazyvimx.extras.ui.better-whitespace`

VSCode-like whitespace visualization in visual mode.

**Features:**

- Shows spaces (·)
- Shows tabs (→)
- Shows nbsp (␣)
- Unix line ending (↩)
- Active only in visual mode

**Plugin:** `mcauley-penney/visual-whitespace.nvim`

### ui.peek-preview

**Import:** `lazyvimx.extras.ui.peek-preview`

VSCode-like peek definitions and references.

**Features:**

- Auto-jump for single result
- Preview window for multiple results
- Custom borders (▁, ▔)
- Fast navigation

**Plugin:** `dnlhc/glance.nvim`

**Keybinding:** `gr` - Go to references (via core.keys)

### ui.better-progressbar

**Import:** `lazyvimx.extras.ui.better-progressbar`

LSP progress via Ghostty OSC 9;4 terminal progress bar instead of in-editor notifications.

**Features:**

- Native Ghostty terminal progress bar via OSC 9;4 escape sequences
- Percentage progress for LSP servers that report it
- Indeterminate (pulsing) progress when percentage is unknown
- Auto-hides when LSP task completes
- Suppresses default noice.nvim LSP progress notifications

**Supported Terminals:** Ghostty, WezTerm, Windows Terminal, Konsole, ConEmu, mintty

### ui.better-float

**Import:** `lazyvimx.extras.ui.better-float`

Consistent rounded borders for all floating windows.

**Applies To:**

- DAP UI
- Mason
- LSP (hover, signature help)
- Neo-tree
- Noice
- Terminals
- Lazygit

**Features:**

- Rounded border style
- Custom sizing
- Backdrop configuration
- Zero winblend for zen mode

---

## Coding Extras

Coding extras enhance programming workflows.

### coding.emmet

**Import:** `lazyvimx.extras.coding.emmet`

Emmet abbreviation expansion for HTML/CSS.

**Features:**

- Emmet language server
- `:EmmetWrap` command
- Works with HTML, CSS, JSX, TSX

**Plugins:**

- `neovim/nvim-lspconfig`
- `olrtg/nvim-emmet`

**Example:**

```
div.container>ul>li*3  →  Expand with Emmet
```

**Keybinding:** Custom (check `:EmmetWrap`)

### coding.comments

**Import:** `lazyvimx.extras.coding.comments`

Enhanced commenting with documentation generation.

**Features:**

- Tree-sitter context-aware commenting
- JSDoc/TSDoc generation
- Multiple doc formats
- Custom comment strings

**Plugins:**

- `nvim-mini/mini.comment`
- `JoosepAlviste/nvim-ts-context-commentstring`
- `kkoomen/vim-doge`

**Keybindings:**

- `gcc` - Toggle comment
- `gcd` - Generate documentation

**JavaScript Config:**

- No destructuring props
- Omit redundant types
- Smart doc generation

---

## Motion Extras

Motion extras improve code navigation.

### motions.splitting-joining-blocks

**Import:** `lazyvimx.extras.motions.splitting-joining-blocks`

Tree-sitter powered block manipulation.

**Features:**

- Split multi-line structures
- Join into single line
- Works with: objects, arrays, functions, JSX

**Plugin:** `Wansmer/treesj`

**Example:**

```javascript
// Split
{ foo: 'bar', baz: 'qux' }
↓
{
  foo: 'bar',
  baz: 'qux'
}

// Join (reverse)
```

### motions.better-cursor-move

**Import:** `lazyvimx.extras.motions.better-cursor-move`

Prevents cursor movement during shift/filter operations.

**Features:**

- Cursor stays in place when shifting
- VSCode compatible
- Predictable behavior

**Plugin:** `gbprod/stay-in-place.nvim`

### motions.better-move-between-words

**Import:** `lazyvimx.extras.motions.better-move-between-words`

Enhanced w/e/b motions with subword support.

**Features:**

- Subword navigation (camelCase)
- Skip insignificant punctuation
- UTF-8 support
- VSCode compatible

**Plugin:** `chrisgrieser/nvim-spider`

**Example:**

```javascript
camelCaseVariable
^    ^    ^        (stops at subwords)
```

**Keybindings:**

- `w` - Next word/subword
- `e` - End of word/subword
- `b` - Previous word/subword

### motions.sibling-move

**Import:** `lazyvimx.extras.motions.sibling-move`

Tree-sitter aware sibling navigation.

**Features:**

- Navigate by syntax nodes
- Highlight on move (250ms)
- Smart jumps

**Plugin:** `aaronik/treewalker.nvim`

**Navigation:**
Move between function parameters, array elements, etc.

### motions.sibling-swap

**Import:** `lazyvimx.extras.motions.sibling-swap`

Swap siblings using Tree-sitter.

**Features:**

- Swap parameters
- Swap array elements
- Swap object properties
- Visual feedback

**Plugin:** `Wansmer/sibling-swap.nvim`

**Keybindings:**

- `<C-,>` - Swap with previous
- `<C-.>` - Swap with next

### motions.langmapper

**Import:** `lazyvimx.extras.motions.langmapper`

**Recommended:** Yes

Russian keyboard layout support.

**Features:**

- Automatic keymap translation
- EN/RU layout switching
- Which-key integration
- Snacks integration
- getcharstr hack for proper translation

**Plugin:** `Wansmer/langmapper.nvim`

**Use Case:**
Use Vim motions with Russian keyboard layout without switching.

---

## Buffer Extras

Buffer extras improve buffer management.

### buf.tab-scope

**Import:** `lazyvimx.extras.buf.tab-scope`

Isolate buffers within tabs.

**Features:**

- Each tab has own buffer list
- Independent buffer navigation per tab
- Cleaner workspace organization

**Plugin:** `tiagovla/scope.nvim`

### buf.delete-no-name

**Import:** `lazyvimx.extras.buf.delete-no-name`

Auto-delete empty [No Name] buffers.

**Features:**

- Triggers on BufHidden
- Only unnamed, unmodified buffers
- Safe deletion via Snacks

**Behavior:**
Opening a new file automatically cleans up empty buffers.

### buf.delete-inactive

**Import:** `lazyvimx.extras.buf.delete-inactive`

Automatic buffer cleanup for inactive buffers.

**Features:**

- 30-minute inactivity threshold
- Auto-delete when source file removed
- Notification on auto-close
- Smart buffer lifecycle

**Plugin:** `chrisgrieser/nvim-early-retirement`

**Benefits:**

- Reduced memory usage
- Cleaner buffer list
- Automatic cleanup

---

## Git Extras

Git extras enhance version control workflows.

### git.fugitive

**Import:** `lazyvimx.extras.git.fugitive`

Comprehensive Git integration.

**Features:**

- Full Git command suite
- GitHub integration (GBrowse)
- GitLab integration
- Token authentication

**Plugins:**

- `tpope/vim-fugitive`
- `tpope/vim-rhubarb` (GitHub)
- `shumphrey/fugitive-gitlab.vim` (GitLab)

**Commands:**

- `:Git` - Run git commands
- `:GBrowse` - Open in GitHub/GitLab
- `:Gdiff` - Show diff

### git.remote-view

**Import:** `lazyvimx.extras.git.remote-view`

Open and browse remote repositories locally.

**Features:**

- Clone and open in new tab
- README auto-open
- Neo-tree integration
- Custom opener functions

**Plugin:** `moyiz/git-dev.nvim`

**Commands:**

- `:GitDevOpen <url>` - Clone and open
- `:GitDevRemoteOpen` - Open remote
- `:GitDevRemoteEnterAndOpen` - Enter and open

### git.gitlab

**Import:** `lazyvimx.extras.git.gitlab`

GitLab MR review within Neovim.

**Features:**

- Review merge requests
- Discussion tree
- Squash merge option
- Comment on diffs
- Approve/reject MRs

**Plugin:** `harrisoncramer/gitlab.nvim`

**Requires:** `ui.diff-view` extra (warns if missing)

**Keybindings:** `<leader>gl*` (via core.keys)

**Commands:**

- `:GitLabMRs` - List MRs
- `:GitLabMRReview` - Review MR
- `:GitLabMRApprove` - Approve MR

### git.conflicts

**Import:** `lazyvimx.extras.git.conflicts`

Visual Git conflict resolution.

**Features:**

- Conflict detection notifications
- Visual conflict markers
- Resolution notifications
- Throttled notifications (3s)

**Plugin:** `akinsho/git-conflict.nvim`

**Markers:**

```
<<<<<<< HEAD
Current changes
=======
Incoming changes
>>>>>>> branch
```

---

## Language Extras

Language extras add support for specific languages.

### lang.ejs

**Import:** `lazyvimx.extras.lang.ejs`

EJS (Embedded JavaScript) template support.

**Features:**

- Registers as eruby filetype
- Embedded template parser
- Tree-sitter integration
- Syntax highlighting

**Plugin:** `nvim-treesitter/nvim-treesitter`

**File Extensions:** `.ejs`

### lang.css

**Import:** `lazyvimx.extras.lang.css`

Enhanced CSS/SCSS support.

**Features:**

- CSS LSP with snippets
- Tree-sitter for CSS/SCSS
- Prettier formatting (if extra enabled)
- Stylelint integration
- ESLint support

**Plugins:**

- `neovim/nvim-lspconfig`
- `nvim-treesitter/nvim-treesitter`
- `stevearc/conform.nvim` (optional)

**Formatters:**

- Prettier (CSS/SCSS)
- Stylelint (CSS/SCSS)

---

## Linting Extras

Linting extras add code quality tools.

### linting.cspell

**Import:** `lazyvimx.extras.linting.cspell`

CSpell spell checker integration.

**Features:**

- Auto-enable if cspell found in project
- Applies to all filetypes
- Project-local detection

**Plugin:** `mfussenegger/nvim-lint`

**Setup:**
Add `cspell.json` to your project:

```json
{
  "version": "0.2",
  "language": "en",
  "words": ["customword"]
}
```

### linting.stylelint

**Import:** `lazyvimx.extras.linting.stylelint`

Ensures stylelint is installed.

**Features:**

- Auto-install via Mason
- CSS/SCSS linting
- Works with lang.css extra

**Plugin:** `mason-org/mason.nvim`

---

## AI Extras

AI extras integrate AI coding assistants.

### ai.avante

**Import:** `lazyvimx.extras.ai.avante`

Cursor AI IDE emulation for Neovim.

**Features:**

- OpenAI GPT-4o integration
- Inline code suggestions
- Chat interface
- File selector integration
- Blink.cmp sources
- Render-markdown support

**Plugin:** `yetone/avante.nvim`

**Configuration:**

```lua
{
	provider = "openai",
	model = "gpt-4o",
	temperature = 0,
	max_tokens = 8192,
}
```

**Keybindings:** `<leader>a*` (via core.keys)

**Requirements:**

- OpenAI API key
- Internet connection

---

## DAP Extras

DAP extras add debugging capabilities.

### dap.vscode-js

**Import:** `lazyvimx.extras.dap.vscode-js`

JavaScript/TypeScript debugger.

**Features:**

- Chrome debugging
- Node.js debugging
- Source map support
- Skip node_modules
- Svelte support

**Plugins:**

- `mfussenegger/nvim-dap`
- `js-debug-adapter` (via `mason.nvim`)

**Configurations:**

1. Chrome (port 8080)
2. Attach to node --inspect
3. Launch file in node (JS only)

**Keybindings:**

- `<F5>` - Continue
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out

**Requires:** `dap.core` extra (warns if missing)

---

## Performance Extras

Performance extras optimize Neovim.

### perf.stop-inactive-lsp

**Import:** `lazyvimx.extras.perf.stop-inactive-lsp`

**Status:** Disabled by default

Garbage collector for inactive LSP clients.

**Features:**

- Auto-stop unused LSP clients
- Free RAM
- Configurable thresholds

**Plugin:** `zeioth/garbage-day.nvim`

**Note:** Currently disabled. Enable at your own risk.

### perf.local-config

**Import:** `lazyvimx.extras.perf.local-config`

Load project-local configuration.

**Features:**

- Supports `.nvim.lua` and `.config/nvim.lua`
- Silent mode (no notifications)
- Per-project customization

**Plugin:** `klen/nvim-config-local`

**Example `.nvim.lua`:**

```lua
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

require("lspconfig").tsserver.setup({
	-- Project-specific LSP config
})
```

### perf.restore-last-colorscheme

**Import:** `lazyvimx.extras.perf.restore-last-colorscheme`

Automatically restore the last used colorscheme on startup.

**Features:**

- Remembers colorscheme across sessions
- Fast restoration on startup
- No manual configuration needed
- Integrates with lazyvimx theme switching

**Plugin:** `raddari/last-color.nvim`

**Use Case:** Useful when frequently switching colorschemes and wanting to preserve your preference between Neovim sessions.

### perf.auto-update-deps

**Import:** `lazyvimx.extras.perf.auto-update-deps`

Auto-update all Mason packages on startup.

**Features:**

- Updates every package installed via Mason (LSP, DAP, linters, formatters)
- Picks up packages installed manually via `:MasonInstall`
- Reuses `ensure_installed` from `mason.nvim` and installed servers from `mason-lspconfig`
- Runs on top of `mason-tool-installer.nvim` with `auto_update = true`

**Plugin:** `WhoIsSethDaniel/mason-tool-installer.nvim`

**Use Case:** Keep language servers and tools current without running `:MasonUpdate` and reinstalling packages by hand.

---

## Test Extras

Test extras integrate testing frameworks.

### test.jest

**Import:** `lazyvimx.extras.test.jest`

Jest testing framework for Neotest.

**Features:**

- Jest test discovery
- Run tests from editor
- Test output in Neotest
- CI environment variable

**Plugins:**

- `nvim-neotest/neotest`
- `haydenmeade/neotest-jest`

**Commands:**

- `:Neotest run` - Run nearest test
- `:Neotest run file` - Run file tests
- `:Neotest summary` - Show summary

**Requires:** `test.core` extra (warns if missing)

---

## Extras Summary

| Category    | Count  | Description                          |
| ----------- | ------ | ------------------------------------ |
| Core        | 4      | Orchestration and core functionality |
| UI          | 19     | Visual enhancements and interface    |
| Coding      | 2      | Coding tools and workflows           |
| Motions     | 6      | Navigation improvements              |
| Buffer      | 3      | Buffer management                    |
| Git         | 4      | Version control integration          |
| Language    | 2      | Language support                     |
| Linting     | 2      | Code quality tools                   |
| AI          | 1      | AI coding assistants                 |
| DAP         | 1      | Debugging support                    |
| Performance | 4      | Optimization                         |
| Test        | 1      | Testing frameworks                   |
| **Total**   | **49** |                                      |

## Recommended Extras

For the best experience, enable:

1. `core.all` - All features
2. `motions.langmapper` - If using Russian keyboard
3. `ui.better-diagnostic` - Better error display
4. `ui.better-float` - Consistent UI
5. `git.conflicts` - If using Git
6. `coding.comments` - Enhanced commenting

## Next Steps

- See [CONFIGURATION.md](CONFIGURATION.md) for setup details
- See [API.md](API.md) for utility functions
- See [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
