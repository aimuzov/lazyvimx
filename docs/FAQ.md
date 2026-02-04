# Frequently Asked Questions (FAQ)

> [!TIP]
> **🇷🇺 Русская версия:** [FAQ.ru.md](FAQ.ru.md)

Common questions and answers about lazyvimx.

## Table of Contents

- [General](#general)
- [Installation](#installation)
- [Configuration](#configuration)
- [Extras](#extras)
- [Troubleshooting](#troubleshooting)
- [Performance](#performance)
- [Integration](#integration)

## General

### What is lazyvimx?

lazyvimx is an enhancement layer for [LazyVim](https://github.com/LazyVim/LazyVim) that provides 48 optional extras and 33 override modules. It's designed to create a highly polished, feature-rich Neovim experience while maintaining compatibility with LazyVim.

### How is lazyvimx different from LazyVim?

lazyvimx **extends** LazyVim, it doesn't replace it:
- **LazyVim**: The foundation - a solid, opinionated Neovim configuration
- **lazyvimx**: Optional enhancements - UI improvements, workflow optimizations, and additional features

You can use lazyvimx with LazyVim and still customize everything the way you want.

### Can I use lazyvimx without LazyVim?

No, lazyvimx is built on top of LazyVim and requires it as a dependency. LazyVim provides the foundation, and lazyvimx enhances it.

### Is lazyvimx stable?

Yes. lazyvimx follows semantic versioning (current: v1.5.0) and maintains backwards compatibility. All extras are optional, so you have full control over what you enable.

### How do I update lazyvimx?

lazyvimx updates automatically with your LazyVim plugins:

```vim
:Lazy update
```

Check the [CHANGELOG.md](CHANGELOG.md) for version-specific changes.

## Installation

### What are the minimum requirements?

- **Neovim** >= 0.10.0
- **LazyVim** (installed automatically)
- **Git** (for plugin management)

### How do I install lazyvimx?

See the [Quick Start](README.md#quick-start) in the README. Basically:

1. Create `~/.config/nvim/init.lua` with lazyvimx boot import
2. Start Neovim
3. Everything installs automatically!

### Can I migrate from LazyVim to lazyvimx?

Yes! lazyvimx is compatible with existing LazyVim configurations:

1. Backup your config: `cp -r ~/.config/nvim ~/.config/nvim.backup`
2. Update your `init.lua` to import lazyvimx boot
3. Restart Neovim
4. Your existing plugins and configs continue to work

### Where should I put my custom plugins?

Same place as LazyVim - in `~/.config/nvim/lua/plugins/`:

```lua
-- ~/.config/nvim/lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  opts = {},
}
```

## Configuration

### How do I configure lazyvimx?

Use the `setup()` function:

```lua
-- ~/.config/nvim/lua/config/lazyvimx.lua or in your plugin spec
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

See [CONFIGURATION.md](docs/CONFIGURATION.md) for all options.

### How do I change the colorscheme?

Two ways:

**Option 1**: Configure in setup (recommended)
```lua
require("lazyvimx").setup({
  colorscheme = "tokyonight",
})
```

**Option 2**: Set directly
```vim
:colorscheme tokyonight-storm
```

### How does theme auto-switching work?

On macOS, lazyvimx detects system light/dark mode and switches automatically:

```lua
colorscheme_flavors = {
  catppuccin = {
    "catppuccin-macchiato",  -- Dark mode
    "catppuccin-latte",      -- Light mode
  },
}
```

Requires `extras.core.overrides` to be enabled.

### Can I disable specific overrides?

Yes, instead of importing `core.overrides`, import categories manually:

```lua
{ import = "lazyvimx.overrides.lazyvim" },   -- Keep this
{ import = "lazyvimx.overrides.snacks" },     -- Keep this
-- { import = "lazyvimx.overrides.bufferline" },  -- Skip this
{ import = "lazyvimx.overrides.other" },      -- Keep this
```

## Extras

### What are extras?

Extras are optional feature modules that enhance functionality. Examples:
- `ui.better-diagnostic` - Inline diagnostic messages
- `motions.langmapper` - Russian keyboard support
- `git.gitlab` - GitLab MR integration

See [EXTRAS.md](docs/EXTRAS.md) for all 48 extras.

### How do I enable extras?

**Via UI** (recommended):
```vim
:LazyExtras
```
Find lazyvimx section `[ 󰬟 ]`, select extras with `x`, restart.

**Via config**:
```lua
{ import = "lazyvimx.extras.ui.better-diagnostic" },
{ import = "lazyvimx.extras.motions.langmapper" },
```

**Enable all**:
```lua
{ import = "lazyvimx.extras.core.all" },
```

### Can I create my own extras?

Yes! See [CONTRIBUTING.md](CONTRIBUTING.md#creating-extras) for a guide on creating custom extras.

### Do I need to enable all extras?

No! Extras are completely optional. Enable only what you need:
- Minimal setup: Just `core.overrides`
- Recommended: `core.all` (includes all extras)
- Custom: Pick and choose individual extras

### Which extras should I enable?

Recommended starter set:
- `core.overrides` - All plugin enhancements
- `ui.better-diagnostic` - Better error display
- `ui.better-float` - Consistent UI
- `motions.langmapper` - If using Russian keyboard
- `git.conflicts` - If using Git

## Troubleshooting

### lazyvimx extras don't show in :LazyExtras

Ensure you imported the boot module:

```lua
{ "aimuzov/lazyvimx", import = "lazyvimx.boot" }
```

### Theme isn't switching automatically

Check:
1. macOS only feature - doesn't work on Linux/Windows
2. Verify system theme: `defaults read -g AppleInterfaceStyle`
3. Enable override: `{ import = "lazyvimx.extras.core.overrides" }`

### Buffer groups aren't working

Enable the override:
```lua
{ import = "lazyvimx.overrides.bufferline.add-groups" }
```

Or via core overrides:
```lua
{ import = "lazyvimx.extras.core.overrides" }
```

### Plugins fail to load

Check logs:
```vim
:Lazy log
```

Common issues:
- Outdated Neovim version (need >= 0.10.0)
- Plugin conflicts - disable conflicting plugins
- Missing dependencies - install with `:Lazy install`

### How do I report a bug?

1. Check [existing issues](https://github.com/aimuzov/lazyvimx/issues)
2. Try minimal config (disable custom plugins)
3. Create new issue with:
   - Neovim version (`:version`)
   - lazyvimx version (`:Lazy`)
   - Steps to reproduce
   - Error messages from `:Lazy log`

See [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) for more solutions.

## Performance

### Is lazyvimx slow?

No. lazyvimx uses lazy loading extensively:
- Extras load only when imported
- Plugins use `optional = true` for graceful degradation
- No impact if extras aren't enabled

### How can I improve performance?

1. **Enable only needed extras** - Don't use `core.all` if you don't need everything
2. **Use perf extras**:
   - `perf.local-config` - Project-specific configs
   - `perf.stop-inactive-lsp` - Clean up unused LSP clients
3. **Check startup time**: `nvim --startuptime startup.log`
4. **Profile**: `:Lazy profile`

### Does lazyvimx slow down Neovim startup?

Minimal impact. The boot module and setup are lightweight. Extras only load if explicitly imported.

Benchmark (cold start):
- LazyVim alone: ~50-80ms
- LazyVim + lazyvimx (minimal): ~55-85ms (+5ms)
- LazyVim + lazyvimx (core.all): ~80-120ms (+30-40ms)

## Integration

### Does lazyvimx work with VSCode Neovim?

Yes! There's a dedicated integration:

```lua
{ import = "lazyvimx.overrides.lazyvim.vscode" }
```

Included in `core.overrides`. Features:
- Mode indicator sync
- Adjusted keybindings
- Native VSCode rename integration

### Can I use lazyvimx with chezmoi?

Yes! Auto-sync is built-in:

```bash
export DOTFILES_SRC_PATH="$HOME/.local/share/chezmoi"
```

Automatically syncs `lazy-lock.json` and `lazyvim.json` on updates.

### Does it work on Linux/Windows?

Yes, lazyvimx works on all platforms. Some features are macOS-specific:
- Auto theme switching (macOS only)
- Trash integration for neo-tree (macOS preferred, but works elsewhere)

### Can I use custom colorschemes?

Yes:

```lua
require("lazyvimx").setup({
  colorscheme = "gruvbox",
  colorscheme_flavors = {
    gruvbox = { "gruvbox-dark", "gruvbox-light" },
  },
})
```

Note: Custom themes won't have lazyvimx's theme customizations unless you create override modules.

## Still Have Questions?

- 📖 Read the [full documentation](docs/)
- 💬 Join [discussion](https://t.me/aimuzov_dotfiles)
- 🐛 [Report an issue](https://github.com/aimuzov/lazyvimx/issues)
- 🤝 [Contribute](CONTRIBUTING.md)
