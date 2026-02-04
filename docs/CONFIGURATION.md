# Configuration Guide

> [!TIP]
> **🇷🇺 Русская версия:** [CONFIGURATION.ru.md](CONFIGURATION.ru.md)

Complete guide to configuring lazyvimx.

## Table of Contents

- [Quick Start](#quick-start)
- [Setup Function](#setup-function)
- [Colorscheme Configuration](#colorscheme-configuration)
- [Buffer Groups](#buffer-groups)
- [Enabling Extras](#enabling-extras)
- [Vim Options](#vim-options)
- [Integration Configuration](#integration-configuration)
- [Advanced Configuration](#advanced-configuration)

## Quick Start

### Minimal Setup

```lua
-- In your lua/config/lazy.lua
return {
	spec = {
		{ "aimuzov/lazyvimx", import = "lazyvimx.boot" }
	},
}
```

This gives you lazyvimx with default settings and makes all extras available via `:LazyExtras`.

### Recommended Setup

```lua
-- In your lua/config/lazy.lua
return {
	spec = {
		{ "aimuzov/lazyvimx", import = "lazyvimx.boot" },
		{ import = "lazyvimx.extras.core.all" },  -- Enable all enhancements
	},
}
```

### Configuration Options

lazyvimx can be configured in two ways:

**Option 1: Using `opts` (Recommended)**

```lua
-- In your init.lua or lua/plugins/lazyvimx.lua
{
	"aimuzov/lazyvimx",
	import = "lazyvimx.boot",
	opts = {
		colorscheme = "catppuccin",
		colorscheme_flavors = {
			catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
		},
		bufferline_groups = {
			["React"] = "%.tsx$",
		},
	},
}
```

**Option 2: Using `setup()` function**

```lua
-- Create lua/config/lazyvimx.lua
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

Both approaches are equivalent - use whichever fits your workflow better.

## Setup Function

The setup function accepts a configuration table that gets deep-merged with defaults.

### Function Signature

```lua
require("lazyvimx").setup(opts?: table)
```

### Configuration Schema

```lua
{
	-- Base colorscheme name
	colorscheme: string,

	-- Light/dark variants for each colorscheme
	colorscheme_flavors: {
		[colorscheme_name: string]: { dark_variant: string, light_variant: string }
	},

	-- Custom buffer groups for bufferline
	bufferline_groups: {
		[group_name: string]: pattern: string  -- Lua pattern
	}
}
```

### Default Configuration

```lua
{
	colorscheme = "catppuccin",

	colorscheme_flavors = {
		catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
		tokyonight = { "tokyonight-storm", "tokyonight-day" },
	},

	bufferline_groups = {
		-- Empty by default
	},
}
```

## Colorscheme Configuration

lazyvimx supports automatic light/dark theme switching based on system preferences (macOS only).

### Basic Configuration

```lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",
})
```

### Flavors (Variants)

Define light and dark variants for each colorscheme:

```lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",
	colorscheme_flavors = {
		catppuccin = {
			"catppuccin-macchiato",  -- [1] Dark variant
			"catppuccin-latte",      -- [2] Light variant
		},
	},
})
```

The system automatically selects:

- Index 1 (dark) when macOS is in dark mode
- Index 2 (light) when macOS is in light mode

### Supported Colorschemes

#### Catppuccin

```lua
colorscheme_flavors = {
	catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
	-- Or use other variants:
	-- catppuccin = { "catppuccin-mocha", "catppuccin-latte" },
	-- catppuccin = { "catppuccin-frappe", "catppuccin-latte" },
}
```

Available variants:

- `catppuccin-mocha` (darkest)
- `catppuccin-macchiato` (dark)
- `catppuccin-frappe` (medium dark)
- `catppuccin-latte` (light)

#### Tokyo Night

```lua
colorscheme_flavors = {
	tokyonight = { "tokyonight-storm", "tokyonight-day" },
	-- Or use other variants:
	-- tokyonight = { "tokyonight-night", "tokyonight-day" },
	-- tokyonight = { "tokyonight-moon", "tokyonight-day" },
}
```

Available variants:

- `tokyonight-night` (darkest)
- `tokyonight-storm` (dark)
- `tokyonight-moon` (medium dark)
- `tokyonight-day` (light)

### Custom Colorschemes

Add your own colorschemes:

```lua
require("lazyvimx").setup({
	colorscheme = "gruvbox",
	colorscheme_flavors = {
		gruvbox = { "gruvbox-dark", "gruvbox-light" },
	},
})
```

**Note:** Custom colorschemes won't have lazyvimx's theme customizations unless you create override modules for them.

### Manual Theme Switching

```vim
:colorscheme catppuccin-latte
:colorscheme tokyonight-storm
```

### Auto-switch on System Theme Change

Enable the override:

```lua
{ import = "lazyvimx.extras.core.overrides" }
-- Or specifically:
{ import = "lazyvimx.overrides.lazyvim.auto-switch-colorscheme-on-signal" }
```

This listens for `Signal` events and switches themes automatically.

## Buffer Groups

Organize buffers in bufferline with custom groups.

### Configuration

```lua
require("lazyvimx").setup({
	bufferline_groups = {
		["Group Name"] = "pattern",  -- Lua pattern matching
	},
})
```

### Examples

#### By File Extension

```lua
bufferline_groups = {
	["TypeScript"] = "%.tsx?$",      -- .ts or .tsx files
	["JavaScript"] = "%.jsx?$",      -- .js or .jsx files
	["Styles"] = "%.s?css$",         -- .css or .scss files
	["Markdown"] = "%.md$",          -- .md files
}
```

#### By Directory

```lua
bufferline_groups = {
	["Components"] = "components/",
	["Pages"] = "pages/",
	["Utils"] = "utils/",
}
```

#### By File Pattern

```lua
bufferline_groups = {
	["Tests"] = "%.test%.",          -- Any .test. file
	["Specs"] = "%.spec%.",          -- Any .spec. file
	["Config"] = "config%.",         -- Files starting with config.
}
```

#### Complex Patterns

```lua
bufferline_groups = {
	["React"] = "%.tsx$",
	["Styles"] = "%.s?css$",
	["Tests"] = "%.test%.tsx?$",
	["API"] = "api/",
	["Components"] = "components/.*%.tsx$",
}
```

### Built-in Groups

lazyvimx provides these groups by default:

- **Pinned**: Manually pinned buffers
- **Ungrouped**: Buffers not matching any pattern
- **Terminal**: Terminal buffers

### Group Display

Groups appear in bufferline with:

- Separator before the group
- Group label
- Grouped buffers
- Separator after the group

Enable the override to use groups:

```lua
{ import = "lazyvimx.overrides.bufferline.add-groups" }
-- Or via core overrides:
{ import = "lazyvimx.extras.core.overrides" }
```

## Enabling Extras

Extras are optional feature modules that enhance functionality.

### Method 1: Via LazyVim Extras UI

1. Open extras picker: `:LazyExtras`
2. Find lazyvimx extras under `[ 󰬟 ]`
3. Enable desired extras with `x`
4. Restart Neovim

### Method 2: Via Plugin Spec

Enable individual extras:

```lua
-- In lua/plugins/lazyvimx.lua
return {
	{ import = "lazyvimx.extras.ui.better-diagnostic" },
	{ import = "lazyvimx.extras.ui.winbar" },
	{ import = "lazyvimx.extras.motions.langmapper" },
}
```

### Method 3: Enable All Extras

```lua
{ import = "lazyvimx.extras.core.extras" }
```

This enables all 43 extras at once.

### Method 4: Category Imports

Import by category (note: not all categories support this):

```lua
{ import = "lazyvimx.extras.ui" }      -- All UI extras
{ import = "lazyvimx.extras.git" }     -- All Git extras
```

### Recommended Core Setup

```lua
{ import = "lazyvimx.extras.core.all" }
```

This includes:

- All overrides
- All extras
- Custom keybindings
- Recommended extras notifications

## Vim Options

lazyvimx configures various Vim options automatically via `boot.lua`.

### Indentation

```lua
vim.o.expandtab = false      -- Use tabs, not spaces
vim.o.smarttab = true        -- Smart tab behavior
vim.o.shiftwidth = 4         -- Indent with 4 columns
vim.o.tabstop = 4            -- Tab displays as 4 columns
vim.o.softtabstop = 4        -- Tab key inserts 4 columns
vim.o.autoindent = true      -- Copy indent from current line
```

### Backup and Swap

```lua
vim.o.swapfile = false       -- Disable swap files
vim.o.backup = true          -- Enable backups
vim.o.backupdir = "~/.local/state/nvim/backup/"
```

### UI Blending

```lua
vim.o.pumblend = 15          -- Popup menu transparency
vim.o.winblend = 5           -- Floating window transparency
```

### Timeouts

```lua
vim.o.timeout = true
vim.o.timeoutlen = 500       -- Wait 500ms for mapped sequence
vim.o.ttimeoutlen = 0        -- No timeout for key codes
```

### Visual Elements

```lua
vim.o.showmode = false       -- Don't show mode (shown in statusline)
vim.o.showbreak = "↪"        -- Line wrap indicator
vim.o.conceallevel = 2       -- Conceal text with replacements
vim.o.smoothscroll = true    -- Smooth scrolling
```

### List Characters

```lua
vim.opt.listchars = {
	eol = " ",                 -- Hidden end of line
	space = " ",               -- Hidden spaces
	tab = "  "                 -- Hidden tabs
}
vim.opt.fillchars:append({
	diff = " ",                -- Empty diff filler
	eob = " "                  -- Empty end of buffer
})
```

### Other Options

```lua
vim.o.autochdir = false      -- Don't auto-change directory
vim.o.spelllang = ""         -- No spell check by default
vim.o.shell = vim.fn.getenv("SHELL")  -- Use system shell
```

### Overriding Options

Create `lua/config/options.lua`:

```lua
-- This runs after lazyvimx options
vim.o.expandtab = true       -- Use spaces instead of tabs
vim.o.shiftwidth = 2         -- 2-space indentation
vim.o.tabstop = 2
```

Or use autocmd:

```lua
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimOptionsDefaults",
	callback = function()
		vim.o.expandtab = true
		vim.o.shiftwidth = 2
	end,
})
```

## Integration Configuration

### Chezmoi Integration

lazyvimx automatically syncs Neovim configuration to chezmoi on updates.

#### Setup

Set environment variable:

```bash
export DOTFILES_SRC_PATH="$HOME/.local/share/chezmoi"
```

Add to your shell profile (`~/.zshrc`, `~/.bashrc`):

```bash
export DOTFILES_SRC_PATH="$HOME/.local/share/chezmoi"
```

#### What Gets Synced

On `:LazyUpdate`, these files are added to chezmoi:

- `~/.config/nvim/lazy-lock.json`
- `~/.config/nvim/lazyvim.json`

#### Enable the Integration

```lua
{ import = "lazyvimx.overrides.lazyvim.auto-apply-chezmoi-on-lazy-update" }
-- Or via core overrides:
{ import = "lazyvimx.extras.core.overrides" }
```

#### Disable the Integration

Don't import the override, or set `DOTFILES_SRC_PATH` to empty.

### VSCode Integration

When running Neovim inside VSCode (via vscode-neovim extension).

#### Mode Indicator

Requires VSCode extension: `nvim-mode-indicator`

lazyvimx automatically syncs Neovim mode to VSCode status bar.

#### Keybinding Adjustments

Some keybindings are disabled in VSCode mode:

- Rename uses VSCode's native rename
- Terminal uses LazyVim.terminal instead of Snacks
- Certain navigation keys are adjusted

#### Enable VSCode Mode

It's enabled automatically when `vim.g.vscode` is true (set by vscode-neovim).

```lua
{ import = "lazyvimx.overrides.lazyvim.vscode" }
-- Or via core overrides:
{ import = "lazyvimx.extras.core.overrides" }
```

### macOS Integration

#### Theme Detection

Automatic on macOS. Reads system preference:

```bash
defaults read -g AppleInterfaceStyle
```

Returns "Dark" or empty (light mode).

#### File Operations

Neo-tree uses macOS-specific commands:

- `trash` command for safe deletion (if available)
- `open` command to open files in default app

#### Requirements

Install `trash` for safe file deletion:

```bash
brew install trash
```

## Advanced Configuration

### Loading Order

Understanding the load order helps with advanced customization:

1. `boot.lua` - Bootstrap and global setup
2. LazyVim plugins - Base LazyVim configuration
3. lazyvimx main module - `require("lazyvimx").setup()`
4. Extras - Optional features you imported
5. Overrides - Plugin customizations
6. User plugins - Your `lua/plugins/*.lua` files

### Per-Project Configuration

Enable local config extra:

```lua
{ import = "lazyvimx.extras.perf.local-config" }
```

Then create in your project:

```lua
-- .nvim.lua or .config/nvim.lua
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Project-specific settings
require("lspconfig").tsserver.setup({
	-- Project-specific LSP config
})
```

### Conditional Extras

Enable extras conditionally:

```lua
return {
	{
		import = "lazyvimx.extras.ui.winbar",
		cond = function()
			return not vim.g.vscode
		end,
	},
}
```

### Custom Keybindings

Override lazyvimx keybindings:

```lua
-- lua/plugins/keys.lua
return {
	{
		"LazyVim/LazyVim",
		keys = {
			-- Disable lazyvimx keybinding
			{ "<leader>\\", false },

			-- Add your own
			{ "<leader>|", "<cmd>vsplit<cr>", desc = "Vertical Split" },
		},
	},
}
```

### Extending Configuration

Add custom config options:

```lua
-- lua/config/lazyvimx.lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",

	-- Custom options
	my_custom_option = "value",
	my_feature_enabled = true,
})

-- Access in your plugins
local config = require("lazyvimx").config
if config.my_feature_enabled then
	-- Do something
end
```

### Theme Customization

Override theme highlights:

```lua
-- lua/plugins/colorscheme.lua
return {
	{
		"catppuccin/nvim",
		opts = {
			custom_highlights = function(colors)
				return {
					Comment = { fg = colors.overlay1 },
					-- More custom highlights
				}
			end,
		},
	},
}
```

### Disabling Overrides

Import core without specific override:

```lua
-- Import overrides manually, skipping some
return {
	{ import = "lazyvimx.overrides.lazyvim" },
	{ import = "lazyvimx.overrides.snacks" },
	-- Skip bufferline overrides
	-- { import = "lazyvimx.overrides.bufferline" },
	{ import = "lazyvimx.overrides.other" },
}
```

### Debug Configuration

Check loaded configuration:

```vim
:lua vim.print(require("lazyvimx").config)
```

Check loaded extras:

```vim
:lua vim.print(require("lazy.core.config").spec.modules)
```

Check if specific extra is loaded:

```lua
local has_extra = require("lazyvimx.util.general").has_extra("ui.winbar")
print(has_extra)
```

## Configuration Examples

### Minimal

```lua
-- lua/config/lazy.lua
return {
	spec = {
		{ "aimuzov/lazyvimx", import = "lazyvimx.boot" }
	},
}
```

### Standard

```lua
-- lua/config/lazy.lua
return {
	spec = {
		{ "aimuzov/lazyvimx", import = "lazyvimx.boot" },
		{ import = "lazyvimx.extras.core.all" },  -- Enable all enhancements
	},
}

-- lua/config/lazyvimx.lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",
})
```

### Full Featured

```lua
-- lua/config/lazy.lua
return {
	spec = {
		{ import = "lazyvimx.boot" },
		{ import = "lazyvimx.extras.core.all" },  -- Enable all enhancements
	},
}

-- lua/config/lazyvimx.lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",
	colorscheme_flavors = {
		catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
	},
	bufferline_groups = {
		["React"] = "%.tsx$",
		["Styles"] = "%.s?css$",
		["Tests"] = "%.test%.",
		["API"] = "api/",
	},
})
```

### Selective Extras

```lua
-- lua/config/lazy.lua
return {
	spec = {
		{ import = "lazyvimx.boot" },

		-- Core
		{ import = "lazyvimx.extras.core.overrides" },
		{ import = "lazyvimx.extras.core.keys" },

		-- UI
		{ import = "lazyvimx.extras.ui.better-diagnostic" },
		{ import = "lazyvimx.extras.ui.winbar" },
		{ import = "lazyvimx.extras.ui.better-float" },

		-- Motions
		{ import = "lazyvimx.extras.motions.langmapper" },

		-- Git
		{ import = "lazyvimx.extras.git.conflicts" },
	},
}
```

## Troubleshooting

### Extras Not Showing in :LazyExtras

Ensure lazyvimx is loaded:

```lua
{ import = "lazyvimx.boot" }
```

Check extras are registered:

```vim
:lua vim.print(require("lazyvim.util.extras").sources)
```

### Theme Not Switching

1. Check macOS system:

   ```bash
   defaults read -g AppleInterfaceStyle
   ```

2. Verify flavors configuration:

   ```vim
   :lua vim.print(require("lazyvimx").config.colorscheme_flavors)
   ```

3. Check override is loaded:

   ```lua
	 { import = "lazyvimx.overrides.lazyvim.auto-switch-colorscheme-on-signal" }
	 ```

### Buffer Groups Not Working

1. Enable the override:

   ```lua
	 { import = "lazyvimx.overrides.bufferline.add-groups" }
	 ```

2. Check configuration:

   ```vim
   :lua vim.print(require("lazyvimx").config.bufferline_groups)
   ```

3. Test pattern:

   ```lua
	 :lua print(vim.fn.expand("%"):match("%.tsx$"))
	 ```

### Chezmoi Not Syncing

1. Check environment variable:

   ```bash
   echo $DOTFILES_SRC_PATH
   ```

2. Verify path exists:

   ```bash
   ls -la $DOTFILES_SRC_PATH
   ```

3. Check override is loaded:

   ```lua
	 { import = "lazyvimx.overrides.lazyvim.auto-apply-chezmoi-on-lazy-update" }
	 ```

## Next Steps

- See [EXTRAS.md](EXTRAS.md) for detailed extra documentation
- See [API.md](API.md) for utility function reference
- See [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
