# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a unified configuration repository for Neovim, Vim, and tmux with consistent keybindings across all tools. The repository includes:
- Modern Neovim setup using Lua with Lazy.nvim plugin manager
- Cross-editor Vim keybindings for IntelliJ IDEA (.ideavimrc) and VS Code (vs-settings.json, vs-keybindings.json)
- Pure Vim configuration (.vimrc) mirroring Neovim keybindings
- Comprehensive tmux configuration (.tmux.conf) with vim-tmux-navigator integration

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
  - Auto-installs: ts_ls, angularls, lua_ls, html, cssls, jdtls
  - Auto-installs tools: prettier, stylua, eslint_d, prettierd
- `nvim-lspconfig.lua`: LSP configurations with custom keybindings and UI tweaks
  - Configures transparent floating windows with borders
  - Sets up LSP servers: TypeScript, HTML, Angular, Lua, CSS, Java
- `nvim-cmp.lua`: Autocompletion with LSP, snippets, buffer, and path sources
  - Tab/Shift-Tab for completion navigation
- `telescope.lua`: Fuzzy finder for files and text search
- `vim-tmux-navigator.lua`: Seamless navigation between Neovim splits and tmux panes
  - Ctrl+h/j/k/l navigation works across Neovim and tmux
- `nvim-autopairs.lua`: Auto-close brackets and quotes
- `colors.lua`: Color scheme configuration
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
- `<C-p>`: Git files (Neovim only)

### LSP/Code Actions
- `gd`: Go to definition
- `gD`: Go to type definition
- `gi`: Go to implementation
- `gr`: Go to references
- `K`: Show hover/documentation
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
- `<leader>f`: Format document

### Editing
- `J/K` (visual mode): Move selected lines down/up
- `<leader>y`: Copy to system clipboard
- `<leader>d`: Delete without yanking
- `<leader>s`: Find and replace current word

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
2. Add server configuration in `lua/diegoagd/plugins/nvim-lspconfig.lua` following existing patterns
3. Restart Neovim - Mason will auto-install the server

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

## Symlink Setup

This repository is designed to be cloned and symlinked to standard config locations:
- `~/.config/nvim` → `/path/to/neovim-config`
- `~/.vimrc` → `/path/to/neovim-config/.vimrc`
- `~/.tmux.conf` → `/path/to/neovim-config/.tmux.conf`

When modifying configs, edit the files in this repository - changes will automatically apply via symlinks.
