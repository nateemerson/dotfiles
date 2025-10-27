# Packer to Lazy.nvim Migration Guide

## Overview
This guide documents the migration from Packer to Lazy.nvim for your Neovim configuration.

## What Changed

### File Structure
```
nvim/
├── lua/
│   ├── config/
│   │   └── lazy.lua              # NEW: Lazy.nvim bootstrap
│   ├── plugins/                  # NEW: Plugin specifications
│   │   ├── ui.lua               # UI & colorscheme plugins
│   │   ├── navigation.lua       # Harpoon, Telescope, Neogit
│   │   ├── lsp.lua              # LSP, Mason, completion
│   │   ├── treesitter.lua       # Treesitter
│   │   └── utils.lua            # Utilities & dependencies
│   └── nateemerson/
│       ├── init.lua             # MODIFIED: Now loads Lazy
│       └── plugins.lua          # DEPRECATED: Old Packer config
├── init.lua                     # MODIFIED: Removed colorscheme (now in ui.lua)
└── plugin/
    └── packer_compiled.lua      # TO DELETE: After migration
```

### Plugin Organization
Plugins have been organized into 5 category files:

1. **ui.lua** - UI components and colorscheme
   - tokyodark.nvim (with config)
   - colorbuddy.vim
   - lualine.nvim (lazy-loaded on VeryLazy)
   - nvim-tree.lua (lazy-loaded on commands)
   - tailwind-highlight.nvim (lazy-loaded by filetype)

2. **navigation.lua** - Navigation tools
   - harpoon
   - telescope (lazy-loaded on command)
   - neogit (lazy-loaded on command)

3. **lsp.lua** - LSP suite and completion
   - lsp-zero.nvim (v2.x branch)
   - nvim-lspconfig
   - mason.nvim + mason-lspconfig.nvim
   - nvim-cmp + all completion sources
   - LuaSnip + friendly-snippets
   - none-ls.nvim (null-ls fork)

4. **treesitter.lua** - Syntax parsing
   - nvim-treesitter (lazy-loaded on file read)

5. **utils.lua** - Utilities and shared dependencies
   - plenary.nvim
   - nvim-autopairs (lazy-loaded on insert)

## Key Differences: Packer vs Lazy.nvim

### Syntax Changes
| Packer | Lazy.nvim | Notes |
|--------|-----------|-------|
| `use 'plugin/name'` | `{ "plugin/name" }` | Wrapped in table |
| `requires = {...}` | `dependencies = {...}` | Renamed key |
| `run = "command"` | `build = "command"` | Renamed key |
| `config = function()` | `config = function()` | Same |
| `cmd = {...}` | `cmd = {...}` | Same |
| N/A | `lazy = true/false` | NEW: explicit lazy loading |
| N/A | `event = "..."` | NEW: event-based loading |
| N/A | `keys = {...}` | NEW: keymap-based loading |
| N/A | `ft = {...}` | NEW: filetype-based loading |
| N/A | `priority = number` | NEW: load order control |

### Lazy Loading
Lazy.nvim is smarter about lazy loading:
- Plugins are NOT lazy by default (changed in config)
- Use `lazy = true` for dependencies
- Use `event`, `cmd`, `keys`, or `ft` for auto lazy-loading
- Use `priority` for plugins that must load early (e.g., colorschemes)

## Potential Issues & Breaking Changes

### 1. Colorscheme Loading
**Issue**: Colorscheme is now configured in `lua/plugins/ui.lua`

**Fix**: The tokyodark settings have been moved from `init.lua` to the plugin spec with `priority = 1000` to ensure it loads first.

### 2. LSP-Zero Configuration
**Issue**: Your `after/plugin/lsp.lua` uses lsp-zero v2.x API which should still work.

**Action Required**: None, but monitor for any LSP issues. The lsp-zero plugin is lazy-loaded appropriately.

### 3. Auto-commands
**Issue**: Packer had an auto-command to sync on save of `plugins.lua`:
```lua
autocmd BufWritePost plugins.lua source <afile> | PackerSync
```

**Fix**: With Lazy.nvim, you don't need this. Lazy auto-detects changes. You can manually sync with `:Lazy sync`.

### 4. Mason Build Hook
**Issue**: Mason had a `run` hook that's now `build`.

**Fix**: Already converted. The build function will run on install/update.

### 5. Plugin Compilation
**Issue**: Packer created `plugin/packer_compiled.lua` for caching.

**Fix**: Lazy.nvim doesn't use this. Delete after confirming migration works.

### 6. Configuration Load Order
**Issue**: With lazy loading, plugins may load in different order.

**Fix**: Added explicit `event = { "BufReadPre", "BufNewFile" }` for LSP to ensure proper loading. Monitor for any timing issues.

## Testing Instructions

### 1. Backup Current Setup
```bash
cd ~/code/dotfiles/nvim
cp -r . ../nvim-backup-$(date +%Y%m%d)
```

### 2. First Launch
1. Close all Neovim instances
2. Launch Neovim: `nvim`
3. Lazy.nvim will auto-install on first run
4. You'll see the Lazy.nvim dashboard installing plugins
5. Wait for all plugins to install
6. Restart Neovim: `:qa` then `nvim`

### 3. Verify Plugin Installation
```vim
:Lazy
```
- Check that all plugins show "Loaded" status
- Look for any errors (red indicators)

### 4. Test LSP Functionality
1. Open a TypeScript/JavaScript file
2. Check LSP is working: `:LspInfo`
3. Verify servers are attached
4. Test completion with `<C-Space>`
5. Test goto definition with `gd`

### 5. Test Mason
```vim
:Mason
```
Verify all your language servers are installed:
- tsserver
- eslint
- rust_analyzer
- lua_ls
- gopls
- tailwindcss
- astro
- volar
- biome

### 6. Test Other Plugins
- Telescope: Test fuzzy finding
- Harpoon: Test file navigation
- Neogit: Open with `:Neogit`
- nvim-tree: Test file explorer
- Treesitter: Check syntax highlighting

### 7. Check for Errors
```vim
:messages
```
Look for any errors or warnings.

### 8. Performance Check
Lazy.nvim should be faster. Check startup time:
```bash
nvim --startuptime startup.log
```
Compare with your backup if curious.

## Troubleshooting

### Plugins Not Loading
1. Check `:Lazy` for errors
2. Run `:Lazy sync` to reinstall
3. Check `:messages` for error details

### LSP Not Working
1. Verify lsp-zero loaded: `:lua print(vim.inspect(require('lsp-zero')))`
2. Check Mason: `:Mason`
3. Reinstall servers if needed
4. Check `after/plugin/lsp.lua` is being sourced

### Completion Not Working
1. Verify nvim-cmp loaded: `:lua print(vim.inspect(require('cmp')))`
2. Check completion sources in insert mode
3. Try `:Lazy reload nvim-cmp`

### Colorscheme Not Loading
1. The colorscheme config is now in `lua/plugins/ui.lua`
2. Verify it loads with priority: `:Lazy load tokyodark.nvim`
3. Manually set if needed: `:colorscheme tokyodark`

## Cleanup Instructions

### After Confirming Everything Works

1. **Remove Packer Bootstrap**
   - Packer was likely installed in `~/.local/share/nvim/site/pack/packer/`
   - You can remove it: `rm -rf ~/.local/share/nvim/site/pack/packer/`

2. **Delete Packer Files**
   ```bash
   cd ~/code/dotfiles/nvim
   rm lua/nateemerson/plugins.lua
   rm plugin/packer_compiled.lua
   ```

3. **Optional: Clean Data Directory**
   If you want to start completely fresh:
   ```bash
   # WARNING: This removes ALL Neovim data
   rm -rf ~/.local/share/nvim/
   rm -rf ~/.cache/nvim/
   ```
   Then relaunch Neovim to reinstall everything.

4. **Remove Backup**
   Once you're confident (after a few days):
   ```bash
   rm -rf ../nvim-backup-<date>
   ```

## Lazy.nvim Commands

Useful commands for managing plugins:

- `:Lazy` - Open plugin manager dashboard
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update plugins only
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for updates
- `:Lazy profile` - View startup profiling
- `:Lazy log` - View recent changes
- `:Lazy help` - View help

## Additional Configuration Options

### Enable Lazy-loading for Keymaps
If you want plugins to load only when you use specific keymaps, add them to the plugin specs:

```lua
{
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  },
}
```

### Enable Auto-updates
Edit `lua/config/lazy.lua`:
```lua
checker = { enabled = true, notify = false },
```

### Lockfile
Lazy.nvim creates a lockfile at `lazy-lock.json`. Consider committing this to your dotfiles for reproducible plugin versions.

## Benefits of Lazy.nvim

1. **Faster startup** - Better lazy loading by default
2. **Better UI** - Beautiful dashboard for managing plugins
3. **Profiling** - Built-in startup profiling
4. **Automatic optimization** - Optimizes runtime path automatically
5. **Simpler syntax** - More intuitive configuration
6. **Active development** - Modern, well-maintained
7. **Better error handling** - Clear error messages and recovery

## Support

If you encounter issues:
1. Check `:checkhealth lazy`
2. Review Lazy.nvim docs: https://github.com/folke/lazy.nvim
3. Check your plugin configs in `after/plugin/` for compatibility
