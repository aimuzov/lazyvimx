# API Reference

> [!TIP]
> **🇷🇺 Русская версия:** [API.ru.md](API.ru.md)

Complete API documentation for lazyvimx utility functions and modules.

## Table of Contents

- [Main Module](#main-module)
- [General Utilities](#general-utilities)
- [Layout Utilities](#layout-utilities)
- [Boot Functions](#boot-functions)
- [Plugin Utilities](#plugin-utilities)

---

## Main Module

**Module:** `lazyvimx`
**Location:** `lua/lazyvimx/init.lua`

### `setup(opts)`

Initialize lazyvimx with custom configuration.

**Signature:**

```lua
function M.setup(opts?: table)
```

**Parameters:**

- `opts` (table, optional) - Configuration options

**Configuration Schema:**

```lua
{
	colorscheme?: string,                    -- Base colorscheme name
	colorscheme_flavors?: {
		[string]: { string, string }           -- { dark_variant, light_variant }
	},
	bufferline_groups?: {
		[string]: string                       -- { group_name: pattern }
	}
}
```

**Default Configuration:**

```lua
{
	colorscheme = "catppuccin",
	colorscheme_flavors = {
		catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
		tokyonight = { "tokyonight-storm", "tokyonight-day" },
	},
	bufferline_groups = {},
}
```

**Usage:**

```lua
require("lazyvimx").setup({
	colorscheme = "tokyonight",
	bufferline_groups = {
		["React"] = "%.tsx$",
	},
})
```

**Returns:** None

**Side Effects:**

- Sets `M.config` with merged configuration
- Available globally as `require("lazyvimx").config`

### `config`

Access current configuration.

**Type:** `table`

**Usage:**

```lua
local config = require("lazyvimx").config
print(config.colorscheme)  -- "catppuccin"
```

---

## General Utilities

**Module:** `lazyvimx.util.general`
**Location:** `lua/lazyvimx/util/general.lua`

### `color_blend(color_first, color_second, percentage)`

Blends two hex colors by percentage.

**Signature:**

```lua
function M.color_blend(
	color_first: string,
	color_second: string,
	percentage: number
): string
```

**Parameters:**

- `color_first` (string) - First hex color (e.g., "#FF0000")
- `color_second` (string) - Second hex color (e.g., "#0000FF")
- `percentage` (number) - Blend percentage (0-100)

**Returns:** (string) - Blended hex color

**Example:**

```lua
local util = require("lazyvimx.util.general")

-- Blend red with blue at 50%
local purple = util.color_blend("#FF0000", "#0000FF", 50)
-- Returns: "#7F007F"

-- Blend with 25% of second color
local light_red = util.color_blend("#FF0000", "#FFFFFF", 25)
-- Returns: "#FF3F3F"
```

**Use Cases:**

- Theme customization
- Dynamic highlight generation
- Color interpolation

**Implementation Note:**
Uses RGB color space for blending.

### `popen_get_result(cmd)`

Execute shell command and return trimmed output.

**Signature:**

```lua
function M.popen_get_result(cmd: string): string
```

**Parameters:**

- `cmd` (string) - Shell command to execute

**Returns:** (string) - Command output (trimmed, no newlines)

**Example:**

```lua
local util = require("lazyvimx.util.general")

local result = util.popen_get_result("echo hello")
-- Returns: "hello"

local theme = util.popen_get_result("defaults read -g AppleInterfaceStyle 2>&1")
-- Returns: "Dark" or ""
```

**Error Handling:**
Returns empty string if command fails or handle is nil.

### `theme_is_dark()`

Check if macOS is in dark mode.

**Signature:**

```lua
function M.theme_is_dark(): boolean
```

**Returns:** (boolean) - `true` if dark mode, `false` otherwise

**Example:**

```lua
local util = require("lazyvimx.util.general")

if util.theme_is_dark() then
	print("Dark mode active")
else
	print("Light mode active")
end
```

**Platform:** macOS only

**Implementation:**

```lua
defaults read -g AppleInterfaceStyle
-- Returns "Dark" in dark mode
-- Returns error in light mode
```

### `get_dotfiles_path()`

Get dotfiles source path from environment.

**Signature:**

```lua
function M.get_dotfiles_path(): string
```

**Returns:** (string) - Dotfiles path or empty string

**Example:**

```lua
local util = require("lazyvimx.util.general")

local path = util.get_dotfiles_path()
if path ~= "" then
	print("Dotfiles at:", path)
end
```

**Environment Variable:** `DOTFILES_SRC_PATH`

**Usage in Code:**

```lua
local dotfiles = util.get_dotfiles_path()
if dotfiles ~= "" then
	local lazy_lock = vim.fn.stdpath("config") .. "/lazy-lock.json"
	vim.fn.system(string.format("chezmoi add %s", lazy_lock))
end
```

### `get_flavor(colorscheme?)`

Get appropriate colorscheme variant based on system theme.

**Signature:**

```lua
function M.get_flavor(colorscheme?: string): string
```

**Parameters:**

- `colorscheme` (string, optional) - Colorscheme name (defaults to config value)

**Returns:** (string) - Colorscheme variant name

**Example:**

```lua
local util = require("lazyvimx.util.general")

-- In dark mode:
local flavor = util.get_flavor("catppuccin")
-- Returns: "catppuccin-macchiato"

-- In light mode:
local flavor = util.get_flavor("catppuccin")
-- Returns: "catppuccin-latte"

-- Use configured colorscheme:
local flavor = util.get_flavor()
```

**Logic:**

1. Checks system theme with `theme_is_dark()`
2. Selects index 1 (dark) or 2 (light)
3. Returns variant from `config.colorscheme_flavors`

### `has_extra(extra)`

Check if specific extra is loaded.

**Signature:**

```lua
function M.has_extra(extra: string): boolean
```

**Parameters:**

- `extra` (string) - Extra name (e.g., "ui.winbar")

**Returns:** (boolean) - `true` if extra is loaded

**Example:**

```lua
local util = require("lazyvimx.util.general")

if util.has_extra("ui.winbar") then
	print("Winbar is enabled")
end

-- Conditional configuration:
if util.has_extra("ui.edgy") then
	-- Configure edgy integration
end
```

**Checks:**

- Lazy.nvim loaded modules
- LazyVim extras JSON data

### `warn_missing_extra(extra_name)`

Create callback that warns if extra is missing.

**Signature:**

```lua
function M.warn_missing_extra(extra_name: string): function
```

**Parameters:**

- `extra_name` (string) - Extra name to check

**Returns:** (function) - Callback function

**Example:**

```lua
local util = require("lazyvimx.util.general")

return {
	{
		"plugin/name",
		init = util.warn_missing_extra("ui.diff-view"),
	}
}

-- Shows notification if ui.diff-view is not loaded:
-- "Missing extra: `ui.diff-view`"
```

**Use Case:**
Warn users about required extras for optional features.

---

## Layout Utilities

**Module:** `lazyvimx.util.layout`
**Location:** `lua/lazyvimx/util/layout.lua`

Manages consistent sizing for sidebars and panels.

### Configuration

**Internal State:**

```lua
local size = {
	left = 40,
	right = 40,
	top = 10,
	bottom = 10,
}

M.step = 3  -- Resize step size
```

### `get_size(pos)`

Get current size for position.

**Signature:**

```lua
function M.get_size(pos: string): number
```

**Parameters:**

- `pos` (string) - Position: "left", "right", "top", or "bottom"

**Returns:** (number) - Size value

**Example:**

```lua
local layout = require("lazyvimx.util.layout")

local left_width = layout.get_size("left")
-- Returns: 40

local bottom_height = layout.get_size("bottom")
-- Returns: 10
```

### `get_size_create(pos)`

Create function that returns size for position.

**Signature:**

```lua
function M.get_size_create(pos: string): function
```

**Parameters:**

- `pos` (string) - Position: "left", "right", "top", or "bottom"

**Returns:** (function) - Function returning size

**Example:**

```lua
local layout = require("lazyvimx.util.layout")

-- Used in plugin configuration:
{
	"plugin/name",
	opts = {
		width = layout.get_size_create("left"),
	}
}

-- Equivalent to:
{
	opts = {
		width = function() return 40 end,
	}
}
```

**Use Case:**
Edgy.nvim and other plugins that accept size functions.

### `increase_create(dir)`

Create function that increases window size.

**Signature:**

```lua
function M.increase_create(dir: string): function
```

**Parameters:**

- `dir` (string) - Direction: "width" or "height"

**Returns:** (function) - Function that increases size

**Example:**

```lua
local layout = require("lazyvimx.util.layout")

-- Used in keybinding:
vim.keymap.set("n", "<C-w>+", function()
	local win = require("edgy").get_win()
	if win then
		layout.increase_create("height")(win)
	end
end)
```

**Behavior:**

- Increases size by `M.step` (default: 3)
- Updates internal state
- Resizes window

### `decrease_create(dir)`

Create function that decreases window size.

**Signature:**

```lua
function M.decrease_create(dir: string): function
```

**Parameters:**

- `dir` (string) - Direction: "width" or "height"

**Returns:** (function) - Function that decreases size

**Example:**

```lua
local layout = require("lazyvimx.util.layout")

-- Used in keybinding:
vim.keymap.set("n", "<C-w>-", function()
	local win = require("edgy").get_win()
	if win then
		layout.decrease_create("height")(win)
	end
end)
```

**Behavior:**

- Decreases size by `M.step` (default: 3)
- Updates internal state
- Resizes window

### Usage in Edgy Configuration

```lua
{
	"folke/edgy.nvim",
	opts = function()
		local layout = require("lazyvimx.util.layout")

		return {
			left = {
				size = layout.get_size_create("left"),
			},
			bottom = {
				size = layout.get_size_create("bottom"),
			},
			keys = {
				["<c-Left>"] = function(win) layout.decrease_create("width")(win) end,
				["<c-Right>"] = function(win) layout.increase_create("width")(win) end,
				["<c-Up>"] = function(win) layout.increase_create("height")(win) end,
				["<c-Down>"] = function(win) layout.decrease_create("height")(win) end,
			},
		}
	end,
}
```

---

## Boot Functions

**Module:** Boot system
**Location:** `lua/lazyvimx/boot.lua`

Internal functions used during bootstrap. Not intended for direct use.

### `set_global()`

Sets global variables for LazyVim configuration.

**Internal Function**

**Sets:**

```lua
vim.g.lazyvim_check_order = false
vim.g.xtras_prios = {}
vim.g.lazyvim_explorer = "neo-tree"
```

### `vimopts_set_values()`

Configures Vim options.

**Internal Function**

See [CONFIGURATION.md#vim-options](./CONFIGURATION.md#vim-options) for details.

### `insert_extras()`

Registers lazyvimx extras in LazyVim extras UI.

**Internal Function**

**Adds Source:**

```lua
{
	name = "[ 󰬟 ]",
	desc = "Some recipes (extras) for enhance lazyvim",
	module = "lazyvimx.extras",
}
```

### `set_colorscheme(_, opts)`

Sets colorscheme based on system theme.

**Internal Function**

**Usage:**

```lua
opts.colorscheme = require("lazyvimx.util.general").get_flavor()
```

### `has_plugins_dir()`

Checks if user has custom plugins directory.

**Internal Function**

**Returns:** (boolean) - `true` if `lua/plugins/*.lua` exists

---

## Plugin Utilities

### Custom Groups for Bufferline

**Function:** `custom_groups_create()`
**Location:** `lua/lazyvimx/overrides/bufferline/add-groups.lua`

Creates custom buffer groups from configuration.

**Returns:** (table) - Bufferline groups configuration

**Usage in Config:**

```lua
require("lazyvimx").setup({
	bufferline_groups = {
		["React"] = "%.tsx$",
	},
})
```

**Generated Groups:**

```lua
{
	name = "React",
	matcher = function(buf)
		return buf.path:match("%.tsx$")
	end,
}
```

---

## Type Definitions

For reference, here are the main type shapes:

### Config Type

```lua
---@class lazyvimxConfig
---@field colorscheme string
---@field colorscheme_flavors table<string, string[]>
---@field bufferline_groups table<string, string>
```

### Layout Size Type

```lua
---@alias LayoutPosition "left"|"right"|"top"|"bottom"
---@alias LayoutDirection "width"|"height"
```

---

## Usage Examples

### Complete Theme Setup

```lua
-- lua/config/lazyvimx.lua
require("lazyvimx").setup({
	colorscheme = "catppuccin",
	colorscheme_flavors = {
		catppuccin = { "catppuccin-macchiato", "catppuccin-latte" },
	},
})

-- lua/plugins/theme.lua
local util = require("lazyvimx.util.general")

return {
	{
		"catppuccin/nvim",
		opts = {
			custom_highlights = function(colors)
				-- Use color blending
				local subtle = util.color_blend(colors.base, colors.overlay0, 30)
				return {
					Comment = { fg = subtle },
				}
			end,
		},
	},
}
```

### Conditional Feature

```lua
-- lua/plugins/conditional.lua
local util = require("lazyvimx.util.general")

return {
	{
		"plugin/name",
		cond = function()
			return util.has_extra("ui.winbar")
		end,
		opts = {
			-- Configuration
		},
	},
}
```

### Layout Integration

```lua
-- lua/plugins/sidebar.lua
local layout = require("lazyvimx.util.layout")

return {
	{
		"sidebar/plugin",
		opts = {
			width = layout.get_size_create("left"),
			resize_keys = {
				["<C-w>>"] = layout.increase_create("width"),
				["<C-w><"] = layout.decrease_create("width"),
			},
		},
	},
}
```

### Dotfiles Integration

```lua
-- lua/plugins/chezmoi.lua
local util = require("lazyvimx.util.general")

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*/nvim/lua/**/*.lua",
	callback = function()
		local dotfiles = util.get_dotfiles_path()
		if dotfiles ~= "" then
			local file = vim.fn.expand("%:p")
			vim.fn.system(string.format("chezmoi add %s", file))
			print("Added to chezmoi:", vim.fn.fnamemodify(file, ":t"))
		end
	end,
})
```

---

## Best Practices

### 1. Check Extra Availability

Always check if extras are loaded before using their features:

```lua
local util = require("lazyvimx.util.general")

if util.has_extra("ui.edgy") then
	-- Configure edgy integration
end
```

### 2. Use Layout Utilities for Consistency

Use layout utilities instead of hardcoded sizes:

```lua
-- ❌ Don't
opts = { width = 40 }

-- ✅ Do
local layout = require("lazyvimx.util.layout")
opts = { width = layout.get_size_create("left") }
```

### 3. Access Config Safely

Check config exists before accessing:

```lua
local ok, config = pcall(function()
	return require("lazyvimx").config
end)

if ok then
	-- Use config
end
```

### 4. Use Color Blending for Themes

Create harmonious colors with blending:

```lua
local util = require("lazyvimx.util.general")

-- Create subtle variant
local subtle_bg = util.color_blend(base_bg, overlay, 15)

-- Create highlight variant
local highlight_fg = util.color_blend(base_fg, accent, 30)
```

---

## API Summary

| Module         | Functions                                                                                 | Purpose            |
| -------------- | ----------------------------------------------------------------------------------------- | ------------------ |
| `lazyvimx`     | `setup()`, `config`                                                                       | Main configuration |
| `util.general` | `color_blend()`, `theme_is_dark()`, `get_flavor()`, `has_extra()`, `warn_missing_extra()` | General utilities  |
| `util.layout`  | `get_size()`, `get_size_create()`, `increase_create()`, `decrease_create()`               | Layout management  |

## See Also

- [CONFIGURATION.md](CONFIGURATION.md) - Configuration guide
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical architecture
- [EXTRAS.md](EXTRAS.md) - Extras reference
