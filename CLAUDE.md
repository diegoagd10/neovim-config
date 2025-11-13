# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a unified configuration repository for Neovim, Vim, and tmux with consistent keybindings across all tools. The repository includes:
- Modern Neovim setup using Lua with Lazy.nvim plugin manager
- Cross-editor Vim keybindings for IntelliJ IDEA (.ideavimrc) and VS Code (vs-settings.json, vs-keybindings.json)
- Pure Vim configuration (.vimrc) mirroring Neovim keybindings
- Comprehensive tmux configuration (.tmux.conf) with vim-tmux-navigator integration

**Important:** This configuration requires Neovim 0.11+ due to the new LSP API (vim.lsp.config, vim.lsp.enable)

## Architecture

### Entry Point
- `init.lua`: Root entry point that loads core configuration and Lazy.nvim plugin manager

### Core Configuration (`lua/diegoagd/core/`)
- `init.lua`: Loads keymaps and settings modules
- `settings.lua`: Global Vim settings (tab width: 2 spaces, relative line numbers, undo history, leader key: space)
- `keymaps.lua`: Base keymaps that are consistent across all editors

### Plugin Management (`lua/diegoagd/`)
- `lazy.lua`: Lazy.nvim bootstrapping and configuration
- Plugins are auto-loaded from `lua/diegoagd/plugins/` directory
- Each plugin is defined as a separate Lua module returning a plugin spec table

### Key Plugins (`lua/diegoagd/plugins/`)
- `mason.lua`: LSP server and tool installer
  - Auto-installs: ts_ls, angularls, lua_ls, html, cssls, pyright
  - Auto-installs tools: prettier, stylua, eslint_d, prettierd, black, ruff
- `nvim-lspconfig.lua`: LSP configurations with custom keybindings and UI tweaks
  - **Uses Neovim 0.11+ API**: vim.lsp.config() and vim.lsp.enable() (not the old lspconfig.setup())
  - Configures transparent floating windows with borders
  - Sets up LSP servers: TypeScript, HTML, Angular, Lua, CSS, Python
  - Note: Java (jdtls) is configured via nvim-java plugin, not here
- `nvim-cmp.lua`: Autocompletion with LSP, snippets, buffer, and path sources
  - Tab/Shift-Tab for completion navigation in insert mode
  - LuaSnip for snippets with friendly-snippets collection
- `telescope.lua`: Fuzzy finder for files, text search, and buffers
- `bufferline.lua`: Visual buffer tabs with LSP diagnostics integration
- `vim-tmux-navigator.lua`: Seamless navigation between Neovim splits and tmux panes
  - Ctrl+h/j/k/l navigation works across Neovim and tmux
  - Note: lazy = false (always loaded for reliability)
- `nvim-java.lua`: Java support with nvim-java plugin (handles jdtls configuration)
- `nvim-treesitter.lua`: Syntax highlighting and code understanding
- `nvim-autopairs.lua`: Auto-close brackets and quotes
- `colors.lua`: Color scheme (Gruvbox)
- `indent.lua`: Indentation guides

### Tmux Configuration (`.tmux.conf`)
- **Prefix Key**: `Ctrl+Space` (matches Neovim leader key)
- **Plugin Manager**: TPM (Tmux Plugin Manager) - plugins defined at bottom of file
- **Key Plugin**: `christoomey/vim-tmux-navigator` - enables seamless Ctrl+h/j/k/l navigation between tmux panes and Neovim splits
- **Pane Resizing**: Uses uppercase `H/J/K/L` (without Ctrl) to avoid conflicts with vim-tmux-navigator
- **Status Bar**: Displays hostname, day, date, and time in 12-hour AM/PM format (e.g., "hostname Sun Nov 9 4:52 PM")

## Common Keybindings (Space is Leader)

These keybindings are consistent across Neovim, IntelliJ IDEA, and VS Code:

### File Navigation
- `<leader>ff`: Find files
- `<leader>fs`: Global text search
- `<leader>fb`: Find buffers (Telescope picker)
- `<C-p>`: Git files (Neovim only)

### Buffer Management
- `<Tab>`: Next buffer
- `<leader><Tab>`: Previous buffer
- `<leader>x`: Close buffer

### LSP/Code Actions
- `gd`: Go to definition
- `gD`: Go to declaration
- `gi`: Go to implementation
- `<leader>td`: Go to type definition
- `K`: Show hover/documentation
- `<leader>k`: Show signature help
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
- `<leader>f`: Format document
- `<leader>e`: Show diagnostics for line

### Editing
- `J/K` (visual mode): Move selected lines down/up
- `<leader>y`: Copy to system clipboard
- `<leader>d`: Delete without yanking
- `<leader>s`: Find and replace current word
- `<leader>fj`: Format JSON with prettier

### Window Management
- `<C-h/j/k/l>`: Navigate between windows/panes (works seamlessly with tmux)
- `<leader>th/<leader>tl>`: Navigate to previous/next tab (Vim only)
- `<leader>|` or `<leader>\`: Split vertically
- `<leader>-` or `<leader>_`: Split horizontally
- `<leader>us`: Unsplit all

### Terminal
- `<leader>tt`: Toggle terminal

## Development Workflow

### Testing Configuration Changes
1. Edit Lua files in `lua/diegoagd/` directory
2. Restart Neovim or run `:source %` to reload current file
3. For plugin changes, run `:Lazy` to manage plugins

### Adding New Plugins
1. Create a new file in `lua/diegoagd/plugins/<plugin-name>.lua`
2. Return a Lazy.nvim plugin spec table with plugin URL and config
3. Restart Neovim - Lazy will auto-detect and install the plugin

### Adding New LSP Servers
1. Add server name to `ensure_installed` table in `lua/diegoagd/plugins/mason.lua:15`
2. Add server configuration in `lua/diegoagd/plugins/nvim-lspconfig.lua` following the Neovim 0.11+ pattern:
   ```lua
   vim.lsp.config("server_name", {
     capabilities = capabilities,
     on_attach = on_attach,
     settings = { ... }  -- optional server-specific settings
   })
   ```
3. Add the server name to the `vim.lsp.enable()` call at the end of nvim-lspconfig.lua
4. Restart Neovim - Mason will auto-install the server

**Important**: Do NOT use the old `require('lspconfig').server_name.setup()` pattern - this config uses the new Neovim 0.11+ API

### Modifying Keybindings
- Neovim: Edit `lua/diegoagd/core/keymaps.lua` for global bindings, or plugin-specific files for plugin bindings
- IntelliJ IDEA: Edit `.ideavimrc`
- VS Code: Edit `vs-settings.json` under `vim.normalModeKeyBindings` or `vim.visualModeKeyBindings`
- Tmux: Edit `.tmux.conf`, then reload with `Ctrl+Space + r` or `tmux source-file ~/.tmux.conf`

### Modifying Tmux Configuration
1. Edit `.tmux.conf` in the repository
2. Reload config: `Ctrl+Space + r` from within tmux, or `tmux source-file ~/.tmux.conf` from terminal
3. For TPM plugin changes: Press `Ctrl+Space + I` (capital I) to install new plugins
4. **Important**: When modifying pane navigation or resizing, remember that `Ctrl+h/j/k/l` is reserved for vim-tmux-navigator. Use uppercase letters or other keys for pane operations.

## Configuration Conventions

- Use 2-space indentation throughout all Lua files
- Plugin configurations should include descriptive keymaps with `desc` parameter
- LSP keybindings are buffer-local and set in the `on_attach` function
- Keep consistency between editor configurations where possible
- Leader key is always space across all editors
- Tmux prefix is `Ctrl+Space` to match Neovim leader key
- The actual config file is `.tmux.conf` (with dot) - this is what tmux loads from `~/.tmux.conf`

### Keybinding Conflict Prevention

When adding new keybindings, always check for conflicts:
1. **Reserved keys**:
   - `<C-h/j/k/l>`: Reserved for vim-tmux-navigator (window/pane navigation)
   - `<Tab>/<S-Tab>`: Used for buffer navigation in normal mode, completion in insert mode
   - `<leader>d`: Delete without yanking (do NOT override)
   - `<leader>f`: Format document (LSP)
   - `<C-p>`: Git files (Telescope)

2. **Before adding a keybinding**: Search the lua/ directory to verify it's not already in use
3. **LSP keybindings**: Always use buffer-local mappings with `{ buffer = bufnr }` to avoid global conflicts

### Plugin Spec Pattern

Each plugin file must return a table with this structure:
```lua
return {
  "author/plugin-name",
  event = "...",              -- or cmd = {...}, keys = {...}
  dependencies = {...},       -- optional
  config = function()
    -- setup code here
  end
}
```

### Lazy-loading Best Practices

- Use `event = { "BufReadPre", "BufNewFile" }` for language/editing plugins
- Use `cmd = { "Command1" }` for command-triggered plugins
- Use `keys = { ... }` for keybinding-triggered plugins
- Set `lazy = false` only when absolutely necessary (e.g., vim-tmux-navigator)

## Symlink Setup

This repository is designed to be cloned and symlinked to standard config locations:
- `~/.config/nvim` → `/path/to/neovim-config`
- `~/.vimrc` → `/path/to/neovim-config/.vimrc`
- `~/.tmux.conf` → `/path/to/neovim-config/.tmux.conf`

When modifying configs, edit the files in this repository - changes will automatically apply via symlinks.
