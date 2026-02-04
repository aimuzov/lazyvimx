# Architecture

> [!TIP]
> **🇷🇺 Русская версия:** [ARCHITECTURE.ru.md](ARCHITECTURE.ru.md)

This document describes the technical architecture and implementation details of lazyvimx.

## Table of Contents

- [Overview](#overview)
- [Bootstrap Process](#bootstrap-process)
- [Module System](#module-system)
- [Configuration System](#configuration-system)
- [Extras System](#extras-system)
- [Overrides System](#overrides-system)
- [Utility Modules](#utility-modules)
- [Integration Points](#integration-points)

## Overview

lazyvimx is designed as an enhancement layer that sits on top of LazyVim, providing optional extras and overrides without disrupting the base LazyVim configuration. It follows a modular architecture where all enhancements are opt-in.

### Design Principles

1. **Non-invasive**: All features are optional and don't interfere with LazyVim's core
2. **Modular**: Each feature is isolated in its own module
3. **Extensible**: Users can easily add their own customizations
4. **Performance-conscious**: Lazy loading and conditional activation
5. **Integration-friendly**: Works seamlessly with chezmoi, VSCode, and system tools

## Bootstrap Process

The bootstrap process is handled by `lua/lazyvimx/boot.lua`, which is the main entry point:

### 1. Entry Point Guard

`init.lua` at the root prevents direct repository usage:

```lua:8
vim.api.nvim_echo({
  { "Do not use this repository directly\n", "ErrorMsg" },
  { "Please check the docs on how to get started with LazyVim (enhanced)\n", "WarningMsg" },
}, true, {})
```

### 2. Bootstrap Sequence

**boot.lua** defines the plugin specification that lazy.nvim processes:

```lua:98
return {
  { import = "system.plug", enabled = set_global },
  { import = "system.plug", enabled = vimopts_create_autocmd },
  { "LazyVim/LazyVim", opts = update_root_lsp_ignore },
  { "LazyVim/LazyVim", opts = insert_extras },
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { "LazyVim/LazyVim", opts = set_colorscheme },
  { "aimuzov/lazyvimx", dependencies = { "LazyVim/LazyVim" }, vscode = true, config = true },
  { import = "plugins", enabled = has_plugins_dir },
}
```

### 3. Initialization Functions

#### Global Variables Setup

```lua:13
local function set_global()
  vim.g.lazyvim_check_order = false
  vim.g.xtras_prios = {}
  vim.g.lazyvim_explorer = "neo-tree"
  return false
end
```

#### Vim Options Configuration

```lua:21
local function vimopts_set_values()
  vim.o.autochdir = false
  vim.o.swapfile = false
  vim.o.backup = true
  -- ... more options
end
```

Key configurations:

- **Indentation**: Tabs with width 4 (no expandtab)
- **UI blending**: `pumblend = 15`, `winblend = 5`
- **Timeouts**: 500ms for mappings, 0ms for key codes
- **Backup**: Enabled with custom directory

#### Extras Integration

```lua:1
local function insert_extras()
  table.insert(require("lazyvim.util.extras").sources, {
    name = "[ 󰬟 ]",
    desc = "Some recipes (extras) for enhance lazyvim",
    module = "lazyvimx.extras",
  })
end
```

This registers lazyvimx extras in the LazyVim extras UI (`:LazyExtras`).

#### Colorscheme Selection

```lua:9
local function set_colorscheme(_, opts)
  opts.colorscheme = require("lazyvimx.util.general").get_flavor()
end
```

Automatically selects light/dark variant based on system theme.

## Module System

### Main Module (`lua/lazyvimx/init.lua`)

The main module provides the configuration interface:

```lua:16
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", defaults, opts or {})
end
```

#### Default Configuration

```lua:3
local defaults = {
  colorscheme = "catppuccin",
  colorscheme_flavors = {
    catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
    tokyonight = { "tokyonight-storm", "tokyonight-day" },
  },
  bufferline_groups = {
    -- ["name"] = "regex",
  },
}
```

### Plugin Detection

```lua:67
local function has_plugins_dir()
  local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"

  if vim.fn.isdirectory(plugins_dir) == 1 then
    local files = vim.fn.glob(plugins_dir .. "/*.lua", 0, 1)
    return #files > 0
  end

  return false
end
```

This allows user plugins to coexist with lazyvimx.

## Configuration System

### Configuration Flow

1. **Defaults defined** in `lua/lazyvimx/init.lua`
2. **User config loaded** via `require("lazyvimx").setup({})`
3. **Deep merge** combines user config with defaults
4. **Config accessible** via `require("lazyvimx").config`

### Configuration Options

#### Colorscheme Management

```lua
colorscheme = "catppuccin"  -- Base colorscheme name
colorscheme_flavors = {
	[colorscheme_name] = { dark_variant, light_variant }
}
```

**Flavor Selection Logic** (`util/general.lua`):

```lua:52
function M.get_flavor(colorscheme)
  local config = require("lazyvimx").config
  local flavor_index = require("lazyvimx.util.general").theme_is_dark() and 1 or 2
  local flavor_list = config.colorscheme_flavors[colorscheme or config.colorscheme]
  local flavor_name = flavor_list[flavor_index]
  return flavor_name
end
```

#### System Theme Detection (macOS)

```lua:40
function M.theme_is_dark()
  local cmd_result = M.popen_get_result("defaults read -g AppleInterfaceStyle 2>&1")
  local theme_is_dark = cmd_result == "Dark"
  return theme_is_dark
end
```

#### Buffer Groups

```lua
bufferline_groups = {
	["Group Name"] = "pattern",  -- Lua pattern matching
}
```

Used by `overrides/bufferline/add-groups.lua` to organize buffers.

## Extras System

### Structure

Extras are organized by category in `lua/lazyvimx/extras/`:

```
extras/
├── core/        # Orchestration and core functionality
├── ui/          # UI enhancements
├── coding/      # Coding tools
├── motions/     # Navigation improvements
├── buf/         # Buffer management
├── git/         # Git integration
├── lang/        # Language support
├── linting/     # Linting tools
├── ai/          # AI assistants
├── dap/         # Debugging
├── perf/        # Performance
└── test/        # Testing
```

### Extra Module Pattern

Each extra is a Lua module that returns a plugin specification:

```lua
-- Standard extra structure
return {
	{
		"plugin/name",
		opts = { ... },
		keys = { ... },
		dependencies = { ... },
	},
}
```

### Core Extras

#### `extras/core/all.lua`

The recommended entry point that loads everything:

```lua:1
return {
  { import = "lazyvimx.extras.core.overrides" },
  { import = "lazyvimx.extras.core.extras" },
  { import = "lazyvimx.extras.core.keys" },
  { "folke/snacks.nvim", opts = function() ... end },
}
```

Also checks for recommended LazyVim extras and notifies if missing.

#### `extras/core/overrides.lua`

Imports all override categories:

```lua:1
return {
  recommended = true,
  { import = "lazyvimx.overrides.lazyvim" },
  { import = "lazyvimx.overrides.snacks" },
  { import = "lazyvimx.overrides.bufferline" },
  { import = "lazyvimx.overrides.other" },
}
```

#### `extras/core/extras.lua`

Central registry of all 48 extras - single import point for all features.

#### `extras/core/keys.lua`

Custom keybindings that integrate with various extras. Conditionally loads based on which extras are enabled.

### Conditional Loading

Extras use conditional loading to avoid errors:

```lua
-- Example from ui/simple-mode.lua
local function is_not_simple_mode()
	return not is_simple_mode()
end

return {
	{ "nvim-neo-tree/neo-tree.nvim", optional = true, cond = is_not_simple_mode },
	{ "akinsho/bufferline.nvim", optional = true, cond = is_not_simple_mode },
}
```

### Extra Detection

Utility function to check if an extra is loaded:

```lua:61
function M.has_extra(extra)
  local Config = require("lazyvim.config")
  local modname = "lazyvimx.extras." .. extra

  return vim.tbl_contains(require("lazy.core.config").spec.modules, modname)
    or vim.tbl_contains(Config.json.data.extras, modname)
end
```

## Overrides System

Overrides modify existing plugin configurations without replacing them entirely.

### Structure

```
overrides/
├── lazyvim/       # LazyVim core customizations
├── snacks/        # Snacks.nvim enhancements
├── bufferline/    # Bufferline.nvim modifications
└── other/         # Other plugin customizations
```

### Override Patterns

#### 1. Options Extension

Most common pattern - extends plugin options:

```lua
return {
	{
		"plugin/name",
		optional = true,
		opts = {
			option1 = value1,
			option2 = value2,
		},
	},
}
```

#### 2. Function Overriding

Replace specific functions:

```lua
-- Example from overrides/lazyvim/lualine-pretty-path.lua
return {
	{
		"LazyVim/LazyVim",
		opts = function()
			local lualine = require("lualine_require").require("lualine.components.filetype")

			LazyVim.lualine.pretty_path = function(opts)
				-- Custom implementation
			end
		end,
	},
}
```

#### 3. Autocmd-based Overrides

Dynamic runtime modifications:

```lua
-- Example from overrides/lazyvim/auto-switch-colorscheme-on-signal.lua
return {
	{
		"LazyVim/LazyVim",
		opts = function()
			vim.api.nvim_create_autocmd("Signal", {
				callback = function()
					-- Switch theme based on system
				end,
			})
		end,
	},
}
```

#### 4. Hook-based Overrides

Modify plugin behavior by wrapping functions:

```lua
-- Example from overrides/snacks/lazygit-fix-theme.lua
local original_open = Snacks.lazygit.open

Snacks.lazygit.open = function(opts)
	-- Set environment before calling original
	vim.env.LG_CONFIG_FILE = config_path
	return original_open(opts)
end
```

### Import System

Overrides use directory-level imports:

```
overrides/
└── lazyvim/
    ├── override1.lua
    ├── override2.lua
    └── init.lua  (optional, for directory-level config)
```

Imported as:

```lua
{ import = "lazyvimx.overrides.lazyvim" }
```

Lazy.nvim automatically loads all `.lua` files in the directory.

## Utility Modules

### `util/general.lua`

General-purpose utilities:

#### Color Blending

```lua:18
function M.color_blend(color_first, color_second, percentage)
  -- Blends two hex colors by percentage
  -- Used extensively in theme customization
end
```

#### Process Execution

```lua:29
function M.popen_get_result(cmd)
  local cmd_handle = io.popen(cmd, "r")
  local cmd_result = cmd_handle ~= nil and cmd_handle:read("*a"):gsub("%s+$", ""):gsub("[\n\r]", "") or ""
  if cmd_handle ~= nil then cmd_handle:close() end
  return cmd_result
end
```

#### Dotfiles Integration

```lua:47
function M.get_dotfiles_path()
  local dotfiles_path = vim.fn.getenv("DOTFILES_SRC_PATH")
  return dotfiles_path ~= vim.NIL and dotfiles_path or ""
end
```

#### Theme Detection

```lua:40
function M.theme_is_dark()
  local cmd_result = M.popen_get_result("defaults read -g AppleInterfaceStyle 2>&1")
  local theme_is_dark = cmd_result == "Dark"
  return theme_is_dark
end
```

### `util/layout.lua`

Window layout management for sidebars:

```lua:3
local size = {
  left = 40,
  right = 40,
  top = 10,
  bottom = 10,
}
```

Used by edgy.nvim and diffview for consistent sizing:

```lua:27
M.step = 3  -- Resize step

function M.get_size(pos)
  return size[pos]
end

function M.increase_create(dir)
  return function(win)
    local step_signed = M.step * 1
    size[win.view.edgebar.pos] = win[dir] + step_signed
    win:resize(dir, step_signed)
  end
end
```

## Integration Points

### LazyVim Integration

1. **Extras System**: Registers in LazyVim extras UI
2. **Config Merging**: Extends LazyVim's options
3. **Plugin Specs**: Compatible with LazyVim plugin structure
4. **Utility Functions**: Uses `LazyVim.*` utilities

### Lazy.nvim Integration

1. **Plugin Spec**: Returns lazy.nvim compatible specs
2. **Import System**: Uses `{ import = "..." }` pattern
3. **Optional Plugins**: Uses `optional = true` for graceful degradation
4. **Conditional Loading**: Uses `cond` and `enabled` for smart loading

### Chezmoi Integration

Auto-sync on LazyVim updates:

```lua
-- overrides/lazyvim/auto-apply-chezmoi-on-lazy-update.lua
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyUpdate",
	callback = function()
		local dotfiles_path = require("lazyvimx.util.general").get_dotfiles_path()
		-- Add files to chezmoi
	end,
})
```

### VSCode Integration

Special mode when running in VSCode:

```lua
-- overrides/lazyvim/vscode.lua
if vim.g.vscode then
	-- Sync mode indicator
	vim.api.nvim_create_autocmd("ModeChanged", {
		callback = function()
			vim.fn.VSCodeNotify("nvim-mode-indicator.update", vim.fn.mode())
		end,
	})
end
```

### macOS Integration

1. **Theme detection**: `defaults read -g AppleInterfaceStyle`
2. **Trash integration**: Uses `trash` command in neo-tree
3. **System open**: `open` command for files

## Performance Considerations

### Lazy Loading

1. **Extras are opt-in**: Only loaded if imported
2. **Conditional plugins**: Use `optional = true`
3. **Runtime checks**: `has_extra()` prevents errors
4. **Event-based loading**: Autocmds for deferred initialization

### Memory Optimization

1. **Inactive LSP cleanup**: `extras/perf/stop-inactive-lsp.lua`
2. **Buffer lifecycle**: Auto-delete inactive buffers
3. **Disabled animations**: `overrides/snacks/disable-animation.lua`

### Startup Optimization

1. **No eager loading**: All extras load on-demand
2. **Plugin guards**: Check plugin availability before use
3. **Deferred configuration**: Use autocmds and lazy callbacks

## Extension Points

### Adding Custom Extras

Create a new extra module:

```lua
-- lua/lazyvimx/extras/category/my-extra.lua
return {
	{
		"plugin/name",
		opts = { ... },
	},
}
```

Add to `extras/core/extras.lua`:

```lua
{ import = "lazyvimx.extras.category.my-extra" },
```

### Adding Custom Overrides

Create override module:

```lua
-- lua/lazyvimx/overrides/category/my-override.lua
return {
	{
		"plugin/name",
		optional = true,
		opts = { ... },
	},
}
```

Will be auto-loaded when importing the category.

### Custom Configuration

Extend the main config:

```lua
require("lazyvimx").setup({
	colorscheme = "tokyonight",
	custom_option = "value",  -- Available as require("lazyvimx").config.custom_option
})
```

## Debug and Development

### Checking Loaded Extras

```lua
:lua vim.print(require("lazy.core.config").spec.modules)
```

### Inspecting Configuration

```lua
:lua vim.print(require("lazyvimx").config)
```

### Reloading Modules

```lua
:lua package.loaded["lazyvimx"] = nil
:lua package.loaded["lazyvimx.util.general"] = nil
```

## Conclusion

lazyvimx's architecture is built around modularity, optional enhancements, and deep integration with LazyVim. The system allows users to pick and choose features while maintaining a cohesive, polished experience. All components are designed to work together seamlessly while remaining independent enough to be used selectively.
