# Troubleshooting Guide

> [!TIP]
> **🇷🇺 Русская версия:** [TROUBLESHOOTING.ru.md](TROUBLESHOOTING.ru.md)

Solutions to common lazyvimx problems.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Extras Not Working](#extras-not-working)
- [Theme and Colorscheme](#theme-and-colorscheme)
- [Performance Problems](#performance-problems)
- [Plugin Conflicts](#plugin-conflicts)
- [LSP Issues](#lsp-issues)
- [Keybinding Problems](#keybinding-problems)
- [macOS-Specific Issues](#macos-specific-issues)
- [Getting Help](#getting-help)

## Installation Issues

### lazyvimx extras don't appear in :LazyExtras

**Symptoms**: Can't see lazyvimx section in `:LazyExtras` UI

**Solutions**:

1. **Verify boot import**:
   ```lua
   -- In your lazy.nvim spec
   { "aimuzov/lazyvimx", import = "lazyvimx.boot" }
   ```

2. **Check extras sources**:
   ```vim
   :lua vim.print(require("lazyvim.util.extras").sources)
   ```
   Should show `[ 󰬟 ]` entry for lazyvimx.

3. **Restart Neovim** after adding boot import

4. **Update plugins**:
   ```vim
   :Lazy update
   ```

### Plugins fail to install

**Symptoms**: Errors during `:Lazy install` or first launch

**Solutions**:

1. **Check Neovim version**:
   ```vim
   :version
   ```
   Must be >= 0.10.0. Update if needed.

2. **Check internet connection**: Lazy.nvim needs to download plugins

3. **Clear cache and retry**:
   ```bash
   rm -rf ~/.local/share/nvim/lazy
   rm -rf ~/.local/state/nvim
   nvim
   ```

4. **Check logs**:
   ```vim
   :Lazy log
   ```

### lazyvimx configuration not loading

**Symptoms**: `require("lazyvimx").setup()` options ignored

**Solutions**:

1. **Check file location**:
   - Should be in `lua/config/lazyvimx.lua` OR
   - In plugin spec with `opts = { ... }`

2. **Check timing**:
   ```lua
   {
     "aimuzov/lazyvimx",
     opts = {
       colorscheme = "catppuccin",
     },
   }
   ```

3. **Verify config loaded**:
   ```vim
   :lua vim.print(require("lazyvimx").config)
   ```

## Extras Not Working

### Extra enabled but not active

**Symptoms**: Extra shows as enabled in `:LazyExtras` but doesn't work

**Solutions**:

1. **Restart Neovim** after enabling extras

2. **Check dependencies**:
   Some extras require other extras. Example:
   - `git.gitlab` requires `ui.diff-view`
   - `dap.vscode-js` requires `dap.core`

3. **Check warnings**:
   ```vim
   :messages
   ```
   Look for "Missing extra" warnings

4. **Verify extra loaded**:
   ```lua
   :lua print(require("lazyvimx.util.general").has_extra("ui.winbar"))
   ```

### Buffer groups not appearing

**Symptoms**: Custom buffer groups don't show in bufferline

**Solutions**:

1. **Enable bufferline override**:
   ```lua
   { import = "lazyvimx.overrides.bufferline.add-groups" }
   ```
   Or include via:
   ```lua
   { import = "lazyvimx.extras.core.overrides" }
   ```

2. **Check configuration**:
   ```vim
   :lua vim.print(require("lazyvimx").config.bufferline_groups)
   ```

3. **Test pattern**:
   ```lua
   :lua print(vim.fn.expand("%"):match("%.tsx$"))
   ```
   Should return match if file is .tsx

4. **Check bufferline installed**:
   ```vim
   :Lazy
   ```
   Find `akinsho/bufferline.nvim`

### Symbol usage not showing

**Symptoms**: Reference counters don't appear

**Solutions**:

1. **Check LSP running**:
   ```vim
   :LspInfo
   ```

2. **Verify extra enabled**:
   ```vim
   :LazyExtras
   ```
   Find `ui.symbol-usage`

3. **Check for conflicts** with other plugins that modify virtual text

4. **Restart LSP**:
   ```vim
   :LspRestart
   ```

## Theme and Colorscheme

### Theme not switching automatically

**Symptoms**: colorscheme doesn't change with system theme

**Solutions**:

1. **macOS only**: This feature only works on macOS

2. **Check system theme**:
   ```bash
   defaults read -g AppleInterfaceStyle
   ```
   Returns "Dark" in dark mode, error in light mode

3. **Enable override**:
   ```lua
   { import = "lazyvimx.overrides.lazyvim.auto-switch-colorscheme-on-signal" }
   ```
   Or via:
   ```lua
   { import = "lazyvimx.extras.core.overrides" }
   ```

4. **Check Signal event**: lazyvimx listens for `Signal` autocmd

5. **Manual test**:
   ```lua
   :lua vim.api.nvim_exec_autocmds("Signal", {})
   ```

### Wrong colorscheme variant

**Symptoms**: Always using dark or light variant

**Solutions**:

1. **Check flavors config**:
   ```vim
   :lua vim.print(require("lazyvimx").config.colorscheme_flavors)
   ```

2. **Verify flavor function**:
   ```lua
   :lua print(require("lazyvimx.util.general").get_flavor())
   ```

3. **Check theme detection**:
   ```lua
   :lua print(require("lazyvimx.util.general").theme_is_dark())
   ```

### Custom colorscheme not working

**Symptoms**: Custom theme doesn't apply

**Solutions**:

1. **Ensure theme installed**:
   ```lua
   {
     "author/my-theme",
     lazy = false,
     priority = 1000,
   }
   ```

2. **Configure flavors**:
   ```lua
   require("lazyvimx").setup({
     colorscheme = "gruvbox",
     colorscheme_flavors = {
       gruvbox = { "gruvbox-dark", "gruvbox-light" },
     },
   })
   ```

3. **Note**: Custom themes won't have lazyvimx customizations unless you create overrides

## Performance Problems

### Slow startup time

**Solutions**:

1. **Profile startup**:
   ```bash
   nvim --startuptime startup.log
   sort -nk2 startup.log | tail -20
   ```

2. **Reduce extras**: Don't use `core.all` if you don't need everything
   ```lua
   -- Instead of
   { import = "lazyvimx.extras.core.all" }
   
   -- Use selective imports
   { import = "lazyvimx.extras.core.overrides" },
   { import = "lazyvimx.extras.ui.better-diagnostic" },
   ```

3. **Check plugin count**:
   ```vim
   :Lazy
   ```
   100+ plugins may slow startup

4. **Enable lazy loading**: Ensure plugins use `lazy = true` or event triggers

### High memory usage

**Solutions**:

1. **Enable inactive LSP cleanup**:
   ```lua
   { import = "lazyvimx.extras.perf.stop-inactive-lsp" }
   ```

2. **Enable buffer cleanup**:
   ```lua
   { import = "lazyvimx.extras.buf.delete-inactive" }
   ```

3. **Check memory usage**:
   ```vim
   :lua print(collectgarbage("count"))
   ```

4. **Force garbage collection**:
   ```vim
   :lua collectgarbage()
   ```

### Laggy UI

**Solutions**:

1. **Disable animations**:
   ```lua
   { import = "lazyvimx.overrides.snacks.disable-animation" }
   ```

2. **Reduce UI extras**:
   - Disable `ui.scrollbar`
   - Disable `ui.symbol-usage`
   - Disable `ui.highlighted-colors`

3. **Check terminal performance**: Some terminals are slower

4. **Reduce treesitter parsers**:
   ```lua
   opts = {
     ensure_installed = { "lua", "vim", "vimdoc" }, -- Only needed languages
   }
   ```

## Plugin Conflicts

### Keybinding conflicts

**Symptoms**: Keybindings don't work or trigger wrong actions

**Solutions**:

1. **Check which-key**:
   ```vim
   :WhichKey
   ```

2. **Find conflicting mapping**:
   ```vim
   :verbose map <leader>cr
   ```

3. **Override in your config**:
   ```lua
   return {
     {
       "LazyVim/LazyVim",
       keys = {
         { "<leader>cr", false },  -- Disable lazyvimx binding
         { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
       },
     },
   }
   ```

### Plugin compatibility issues

**Symptoms**: Errors when using certain plugins together

**Solutions**:

1. **Check logs**:
   ```vim
   :Lazy log
   :messages
   ```

2. **Disable extras one by one** to find conflict

3. **Check plugin requirements**: Some plugins need specific versions

4. **Report issue**: If it's a lazyvimx bug, open GitHub issue

## LSP Issues

### LSP not starting

**Solutions**:

1. **Check LSP status**:
   ```vim
   :LspInfo
   ```

2. **Check Mason**:
   ```vim
   :Mason
   ```
   Ensure language server installed

3. **Manual install**:
   ```vim
   :MasonInstall typescript-language-server
   ```

4. **Check logs**:
   ```vim
   :LspLog
   ```

### Diagnostics not showing

**Solutions**:

1. **Check diagnostic config**:
   ```lua
   :lua vim.print(vim.diagnostic.config())
   ```

2. **If using better-diagnostic**: Verify extra enabled
   ```vim
   :LazyExtras
   ```

3. **Toggle diagnostics**:
   ```vim
   :lua vim.diagnostic.enable()
   ```

4. **Check LSP attached**:
   ```vim
   :LspInfo
   ```

### Rename not working

**Solutions**:

1. **Check if live-rename enabled**:
   ```vim
   :LazyExtras
   ```
   Find `ui.better-live-rename`

2. **Use default rename**:
   ```vim
   :lua vim.lsp.buf.rename()
   ```

3. **Check LSP supports rename**:
   ```lua
   :lua print(vim.lsp.get_active_clients()[1].server_capabilities.renameProvider)
   ```

## Keybinding Problems

### Keybindings don't work

**Solutions**:

1. **Ensure extras.core.keys imported**:
   ```lua
   { import = "lazyvimx.extras.core.keys" }
   ```
   Or via `core.all`

2. **Check if VSCode mode**: Some keys behave differently in VSCode

3. **Verify mapping exists**:
   ```vim
   :verbose nmap <leader>cr
   ```

4. **Check leader key**:
   ```vim
   :echo mapleader
   ```
   Should be space by default

### Russian keyboard not working

**Symptoms**: Vim motions don't work with Russian layout

**Solutions**:

1. **Enable langmapper extra**:
   ```lua
   { import = "lazyvimx.extras.motions.langmapper" }
   ```

2. **Restart Neovim** after enabling

3. **Check layout mapping**:
   ```lua
   :lua print(require("langmapper").get_lang())
   ```

4. **Verify which-key integration**: Should work automatically

## macOS-Specific Issues

### System theme detection not working

**Solutions**:

1. **Check defaults command**:
   ```bash
   defaults read -g AppleInterfaceStyle 2>&1
   ```

2. **Grant terminal permissions**: System Preferences → Security → Full Disk Access

3. **Test theme function**:
   ```lua
   :lua print(require("lazyvimx.util.general").theme_is_dark())
   ```

### Trash integration not working

**Solutions**:

1. **Install trash-cli**:
   ```bash
   brew install trash
   ```

2. **Check trash command**:
   ```bash
   which trash
   ```

3. **Fallback**: Will use `rm` if `trash` not available

### Chezmoi sync not working

**Solutions**:

1. **Check environment variable**:
   ```bash
   echo $DOTFILES_SRC_PATH
   ```

2. **Set in shell profile**:
   ```bash
   # ~/.zshrc or ~/.bashrc
   export DOTFILES_SRC_PATH="$HOME/.local/share/chezmoi"
   ```

3. **Verify path exists**:
   ```bash
   ls -la $DOTFILES_SRC_PATH
   ```

4. **Check override enabled**:
   ```lua
   { import = "lazyvimx.overrides.lazyvim.auto-apply-chezmoi-on-lazy-update" }
   ```

## Getting Help

If none of these solutions work:

1. **Check FAQ**: [FAQ.md](FAQ.md)

2. **Search issues**: [GitHub Issues](https://github.com/aimuzov/lazyvimx/issues)

3. **Ask community**: [Telegram Discussion](https://t.me/aimuzov_dotfiles)

4. **Create issue**: Include:
   - Neovim version (`:version`)
   - lazyvimx version (`:Lazy`)
   - Operating system
   - Minimal reproduction steps
   - Error messages (`:Lazy log`, `:messages`)
   - Relevant config

5. **Provide minimal config**:
   ```lua
   -- Minimal reproduction
   local lazy_opts = {
     spec = {
       { "aimuzov/lazyvimx", import = "lazyvimx.boot" },
       { import = "lazyvimx.extras.core.all" },
     },
   }
   
   -- Bootstrap and setup
   -- ... (standard bootstrap code)
   ```

## Debugging Tips

### Enable verbose logging

```lua
vim.o.verbose = 9
vim.o.verbosefile = vim.fn.stdpath("cache") .. "/vim.log"
```

### Check loaded modules

```vim
:lua vim.print(package.loaded)
```

### Inspect plugin spec

```vim
:lua vim.print(require("lazy.core.config").spec.modules)
```

### Profile plugins

```vim
:Lazy profile
```

### Check autocmds

```vim
:autocmd Signal
:autocmd User LazyUpdate
```

---

**Still stuck?** Don't hesitate to ask for help. The community is here to assist!
