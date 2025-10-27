# Claude Code Working Guide - Dotfiles Repository

## Repository Overview

This is a personal dotfiles repository for macOS development environments. It contains configuration files for:
- **Neovim** (primary editor, Lua-based configuration)
- **Zsh** (shell configuration with plugins)
- **Git** (version control settings)
- **Kitty** (terminal emulator)
- **Tmux** (terminal multiplexer)
- **Vim** (legacy configuration, still maintained)

**Current Branch:** `2025-update`
**Main Branch:** `master`
**Remote:** `https://github.com/nateemerson/dotfiles.git`

## File Structure and Locations

### Neovim Configuration (`nvim/`)

```
nvim/
├── init.lua                          # Main entry point
├── lazy-lock.json                    # Plugin version lockfile (commit this!)
├── LAZY_MIGRATION_GUIDE.md          # Migration notes from Packer
├── lua/
│   ├── config/
│   │   └── lazy.lua                 # Lazy.nvim plugin manager bootstrap
│   ├── plugins/                     # Plugin specifications (Lazy.nvim)
│   │   ├── lsp.lua                  # LSP, Mason, completion, snippets
│   │   ├── ui.lua                   # Colorscheme, statusline, file explorer
│   │   ├── navigation.lua           # Harpoon, Telescope, Neogit
│   │   ├── treesitter.lua          # Syntax highlighting
│   │   └── utils.lua                # Utility plugins
│   └── nateemerson/                 # User configuration modules
│       ├── init.lua                 # Loads all modules
│       ├── base.lua                 # Core editor settings
│       ├── keymaps.lua              # Custom keybindings
│       ├── lsp/                     # LSP configuration
│       │   ├── handlers.lua         # LSP callbacks and diagnostics
│       │   ├── mason.lua            # LSP installer UI settings
│       │   ├── null-ls.lua          # Formatting and linting
│       │   └── settings/            # Language-specific LSP configs
│       ├── cmp.lua                  # Autocompletion setup
│       ├── autopairs.lua            # Auto-closing brackets
│       ├── telescope.lua            # Fuzzy finder config
│       ├── tree.lua                 # File explorer setup
│       └── neogit.lua               # Git integration
└── after/plugin/                    # Post-load plugin configurations
    ├── lsp.lua                      # LSP-Zero configuration (IMPORTANT!)
    ├── telescope.lua
    ├── treesitter.lua
    └── ...
```

### Zsh Configuration

```
├── zshrc                            # Main interactive shell config
├── zshenv                           # Environment variables (XDG paths)
├── zprofile                         # System initialization (Homebrew, paths)
└── zsh/
    ├── functions/                   # Custom shell functions (g, gpo, gfu)
    └── completion/                  # Custom completions (_g)
```

### Other Configurations

```
├── gitconfig                        # Git user settings
├── vimrc                            # Legacy Vim config (still maintained)
├── tmux.conf                        # Tmux settings
├── kitty/                           # Kitty terminal configuration
├── bin/                             # Custom scripts and utilities
└── install_mac.zsh                  # macOS installation script
```

## Critical Knowledge

### 1. LSP Configuration Architecture

**IMPORTANT:** There are TWO places where LSP is configured:

1. **`nvim/after/plugin/lsp.lua`** (PRIMARY)
   - Uses lsp-zero v2.x framework
   - Defines which LSP servers to install via `lsp.ensure_installed({})`
   - Configures keymaps and completion
   - Runs AFTER plugins are loaded

2. **`nvim/lua/nateemerson/lsp/`** (SUPPORTING)
   - `handlers.lua`: LSP callbacks, diagnostics, keymaps
   - `mason.lua`: Mason UI settings ONLY (NOT server installation)
   - `null-ls.lua`: Formatting and linting configuration

**Rule:** Server installation and configuration happens in `after/plugin/lsp.lua`. Mason only handles UI settings.

### 2. LSP Server Naming (Neovim 0.11+)

Current server names as of 2025:
- `ts_ls` (NOT `tsserver` - deprecated)
- `vue_ls` (NOT `volar` - deprecated)
- `lua_ls`, `eslint`, `rust_analyzer`, `gopls`, `tailwindcss`, `astro`, `biome`

**Always use current names.** Check [lspconfig server configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for updates.

### 3. Neovim 0.11+ API Changes

**Deprecated Patterns:**
- ❌ `require('lspconfig').server_name.setup({})`
- ❌ `vim.fn.sign_define()` for diagnostic signs
- ❌ `signs = { active = signs }` in diagnostic config

**Current Patterns:**
- ✅ Use lsp-zero's `lsp.configure()` or `lsp.ensure_installed()`
- ✅ Use `signs = { text = { Error = "...", Warn = "..." } }` directly in `vim.diagnostic.config()`

### 4. Plugin Management with Lazy.nvim

**Plugin specifications live in:** `nvim/lua/plugins/*.lua`

**Common patterns:**
```lua
{
  "author/plugin-name",
  dependencies = { "other/plugin" },  -- NOT "requires"
  build = "command",                  -- NOT "run"
  lazy = true,                        -- Explicit lazy-loading
  cmd = "Command",                    -- Load on command
  event = "InsertEnter",              -- Load on event
  ft = { "lua", "vim" },              -- Load on filetype
  keys = { "<leader>x" },             -- Load on keymap
  config = function()
    -- Configuration code
  end,
}
```

**Priority loading:**
- Colorschemes need `lazy = false, priority = 1000`
- Dependencies should have `lazy = true`

**Lazy.nvim commands:**
- `:Lazy` - Open dashboard
- `:Lazy sync` - Install/update/clean all
- `:Lazy update` - Update only
- `:Lazy clean` - Remove unused plugins

### 5. Development Environment Setup

**Node.js:** Multiple version managers are configured:
- NVM (primary)
- Volta
- PNPM
- Bun

**Other Languages:**
- Go: `/usr/local/go/bin`
- OCaml: OPAM integration in `zprofile`
- Python: System Python + potential virtualenvs

**Environment Management:**
- Direnv for per-project variables
- XDG Base Directory compliance (`ZDOTDIR`, `XDG_CONFIG_HOME`, etc.)

## Common Tasks and Workflows

### Adding a New Neovim Plugin

1. **Determine the category:**
   - UI/colorscheme → `lua/plugins/ui.lua`
   - Navigation tool → `lua/plugins/navigation.lua`
   - LSP/completion → `lua/plugins/lsp.lua`
   - Syntax/parsing → `lua/plugins/treesitter.lua`
   - Utility → `lua/plugins/utils.lua`

2. **Add the plugin specification:**
   ```lua
   {
     "author/plugin-name",
     dependencies = { "required/plugin" },
     lazy = true,  -- or false for immediate loading
     event = "BufReadPost",  -- or cmd, ft, keys
     config = function()
       require("plugin-name").setup({
         -- configuration
       })
     end,
   }
   ```

3. **Test the plugin:**
   - Restart Neovim or run `:Lazy reload plugin-name`
   - Run `:Lazy sync` to install
   - Check `:checkhealth` if it's an LSP or major plugin

4. **Commit the lockfile:**
   ```bash
   git add nvim/lazy-lock.json
   ```

### Adding a New LSP Server

1. **Add to ensure_installed list in `nvim/after/plugin/lsp.lua`:**
   ```lua
   lsp.ensure_installed({
     'ts_ls',
     'your_new_server',  -- Add here
     -- ... other servers
   })
   ```

2. **Optional: Add language-specific configuration:**
   ```lua
   lsp.configure('your_new_server', {
     settings = {
       -- Server-specific settings
     }
   })
   ```

3. **Test:**
   - Open a file of the appropriate type
   - Run `:LspInfo` to verify attachment
   - Run `:Mason` to check installation status

### Adding Custom Zsh Functions

1. **Create function file:** `zsh/functions/function_name`
2. **Make it autoloadable:** Functions in this directory are auto-loaded by `zshrc`
3. **Restart shell or:** `source ~/.zshrc`

### Modifying Git Configuration

**Edit:** `gitconfig`

**Common sections:**
- `[user]` - Name and email
- `[core]` - Editor, excludes, pager
- `[color]` - UI colors
- `[credential]` - Credential helper

**Test:** `git config --list --show-origin`

## Making Changes: Best Practices

### 1. Branch Strategy

- Main work happens on feature branches
- `2025-update` is the current active branch
- Merge to `master` when stable

### 2. Commit Message Format

**Format:**
```
Short summary (50 chars max)

Detailed explanation of what changed and why. Focus on the "why"
rather than the "what". Can be multiple paragraphs.

- Bullet points for specific changes
- Include any breaking changes
- Note any required manual steps
```

**Example from this repo:**
```
Migrate Neovim package manager from Packer to Lazy.nvim

Complete migration from Packer to Lazy.nvim plugin manager to take
advantage of better performance, modern API, and improved lazy loading.

Changes:
- Created lua/config/lazy.lua with bootstrap configuration
- Organized plugins into 5 category files (ui, navigation, lsp, treesitter, utils)
- Updated all plugin specs from Packer to Lazy.nvim syntax
- Modernized LSP configuration for Neovim 0.11+ compatibility
- Updated server names: tsserver → ts_ls, volar → vue_ls
- Removed deprecated diagnostic signs API usage
```

### 3. Testing Changes

**For Neovim changes:**
1. Open a test file of relevant type
2. Check for errors: `:messages`
3. Verify LSP: `:LspInfo`
4. Check plugin status: `:Lazy`
5. Run health checks: `:checkhealth` or `:checkhealth plugin_name`

**For Zsh changes:**
1. Source the file: `source ~/.zshrc`
2. Test relevant functions
3. Check for errors in shell output

**For git changes:**
1. Run a safe git command: `git status`
2. Verify config: `git config --list`

### 4. Deprecation Handling

**When you see deprecation warnings:**
1. Note the exact warning message
2. Check the suggested replacement (often in warning message)
3. Search for all occurrences: `grep -r "deprecated_pattern" nvim/`
4. Update all occurrences at once
5. Test thoroughly

**Common deprecations to watch for:**
- LSP server name changes
- Neovim API changes
- Plugin API updates

## File Modification Guidelines

### Files That Should Always Work Together

**If you modify one, check the others:**

1. **LSP Configuration:**
   - `nvim/after/plugin/lsp.lua`
   - `nvim/lua/nateemerson/lsp/handlers.lua`
   - `nvim/lua/nateemerson/lsp/mason.lua`
   - `nvim/lua/plugins/lsp.lua`

2. **Plugin Management:**
   - `nvim/lua/config/lazy.lua`
   - `nvim/lua/plugins/*.lua`
   - `nvim/lazy-lock.json` (auto-generated, commit it)

3. **Zsh Initialization:**
   - `zshenv` (loaded first)
   - `zprofile` (loaded second)
   - `zshrc` (loaded last for interactive shells)

### Files to Never Manually Edit

- `nvim/lazy-lock.json` - Auto-generated by Lazy.nvim (but DO commit it)
- `bin/antigen.zsh` - Downloaded third-party script

### Files Requiring Special Care

**`nvim/after/plugin/lsp.lua`**
- This is the PRIMARY LSP configuration
- Uses lsp-zero v2.x API
- Changes here affect ALL language servers
- Always test with multiple file types after changes

**`zshrc`**
- Loaded on every shell startup
- Performance-sensitive
- Test startup time: `time zsh -i -c exit`

**`gitconfig`**
- Contains personal email/name
- Some settings are macOS-specific (keychain credential helper)

## Common Pitfalls and Solutions

### Pitfall 1: Duplicate LSP Configuration

**Problem:** LSP servers configured in both lsp-zero and mason-lspconfig
**Solution:** Use ONLY lsp-zero's `ensure_installed()` in `after/plugin/lsp.lua`. Mason should only handle UI settings.

### Pitfall 2: Wrong LSP Server Names

**Problem:** Using deprecated server names (tsserver, volar)
**Solution:** Always check current names in nvim-lspconfig documentation. Common renames:
- `tsserver` → `ts_ls`
- `volar` → `vue_ls`

### Pitfall 3: Plugin Load Order Issues

**Problem:** Plugin not available when config runs
**Solution:**
- Use `dependencies = {}` to ensure load order
- Use `lazy = false, priority = 1000` for plugins needed early (colorschemes)
- Move configuration to `config = function()` to run after plugin loads

### Pitfall 4: Path Issues in Zsh

**Problem:** Commands not found after shell changes
**Solution:**
- Check PATH in all three files: `zshenv`, `zprofile`, `zshrc`
- Remember load order: env → profile → rc
- Use `echo $PATH` to debug
- Ensure PATH additions use proper syntax: `export PATH="/new/path:$PATH"`

### Pitfall 5: Breaking Changes Without Documentation

**Problem:** Making breaking changes without noting required manual steps
**Solution:**
- Always create migration guides for major changes (see `LAZY_MIGRATION_GUIDE.md`)
- Include manual steps in commit message
- Test on a fresh checkout when possible

## Git Workflow for This Repo

### User Information

```bash
Name: Nate Emerson
Email: emerson.nate@gmail.com
```

These are configured globally. Commits should use these credentials.

### Typical Workflow

```bash
# 1. Make changes
# 2. Test thoroughly
# 3. Stage changes
git add <files>

# 4. Commit with good message
git commit -m "Short summary

Detailed explanation of changes and why they were made.

- Specific change 1
- Specific change 2"

# 5. Push to remote
git push origin 2025-update
```

### Branch Management

- **Feature work:** Create feature branches off `2025-update`
- **Stable changes:** Merge to `master` after testing
- **Experimental:** Keep on feature branches until proven

## Emergency Procedures

### Neovim Won't Start

1. **Check for syntax errors:**
   ```bash
   nvim --headless +q
   ```

2. **Disable plugins temporarily:**
   ```bash
   nvim --noplugin
   ```

3. **Check recent changes:**
   ```bash
   git diff HEAD~1
   ```

4. **Revert if needed:**
   ```bash
   git revert HEAD
   ```

### Shell Configuration Broken

1. **Start with clean shell:**
   ```bash
   zsh -f
   ```

2. **Source files individually to find culprit:**
   ```bash
   source ~/.zshenv
   source ~/.zprofile
   source ~/.zshrc
   ```

3. **Revert changes:**
   ```bash
   git checkout HEAD -- zshrc
   ```

### LSP Servers Not Working

1. **Check Mason installation:**
   ```vim
   :Mason
   ```

2. **Reinstall server:**
   - In Mason UI, press `X` to uninstall, then `i` to install

3. **Check lsp-zero status:**
   ```vim
   :LspInfo
   :messages
   ```

4. **Nuclear option - reinstall all:**
   ```bash
   rm -rf ~/.local/share/nvim/mason
   ```
   Then `:Mason` and reinstall servers

## External Resources

- **Lazy.nvim docs:** https://github.com/folke/lazy.nvim
- **LSP-Zero docs:** https://github.com/VonHeikemen/lsp-zero.nvim/tree/v2.x
- **nvim-lspconfig servers:** https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
- **Neovim docs:** `:help` or https://neovim.io/doc/
- **Zsh docs:** http://zsh.sourceforge.net/Doc/

## Maintenance Checklist

### Monthly

- [ ] Run `:Lazy update` to update plugins
- [ ] Review and commit `lazy-lock.json` changes
- [ ] Check for Neovim updates: `nvim --version`
- [ ] Update Homebrew packages: `brew upgrade`

### When Adding New Plugins

- [ ] Add to appropriate category file in `lua/plugins/`
- [ ] Set proper lazy-loading strategy
- [ ] Add dependencies if needed
- [ ] Test installation with `:Lazy sync`
- [ ] Check health with `:checkhealth plugin_name`
- [ ] Commit `lazy-lock.json` changes

### When Modifying LSP Configuration

- [ ] Update `after/plugin/lsp.lua` (primary config)
- [ ] Check for deprecated server names
- [ ] Test with relevant file types
- [ ] Verify with `:LspInfo`
- [ ] Check `:messages` for errors
- [ ] Update handlers/mason if needed

### Before Pushing to Remote

- [ ] Test all changes in a real editing session
- [ ] Check for error messages (`:messages` in Neovim)
- [ ] Verify git author info is correct
- [ ] Ensure commit message is well-formatted
- [ ] Run relevant health checks
- [ ] Commit lockfiles and generated files

## Notes for Claude Code

### Context to Always Remember

1. This is a **macOS-specific** configuration
2. Neovim uses **Lua** (not Vimscript) for modern configuration
3. Plugin manager is **Lazy.nvim** (migrated from Packer in 2025)
4. LSP configuration uses **lsp-zero v2.x** framework
5. Target Neovim version is **0.11+** (use modern APIs)
6. User prefers **detailed commit messages** with 50-char summaries

### When Making Changes

1. **Always read the file first** before editing
2. **Preserve exact indentation** (this codebase uses spaces, typically 2 or 4)
3. **Update lockfiles** when modifying plugins
4. **Check for deprecated APIs** and suggest modern alternatives
5. **Test instructions** should be specific and actionable
6. **Document breaking changes** in commit messages

### Preferred Communication Style

- Concise, technical explanations
- Focus on "why" not just "what"
- Provide file paths with line numbers (`file:line`)
- Suggest testing steps after changes
- Offer rollback instructions for risky changes

### Anti-Patterns to Avoid

- Don't use deprecated LSP server names
- Don't manually edit `lazy-lock.json`
- Don't configure LSP servers in mason.lua (use lsp-zero)
- Don't add emoji to commits unless explicitly requested
- Don't create unnecessary documentation files without being asked
- Don't use `require('lspconfig').server.setup()` (use lsp-zero API)
