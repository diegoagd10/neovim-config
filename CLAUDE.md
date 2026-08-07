# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a unified configuration repository for Neovim, IntelliJ IDEA (IdeaVim), VS Code (VSCodeVim), Helix, and tmux with consistent Vim-style keybindings across all tools. The repository includes:
- Repo-owned Neovim configuration (`nvim/`) with focused plugins, LSP, formatting, and completion
- Cross-editor Vim keybindings for IntelliJ IDEA (`.ideavimrc`) and VS Code (`vs-settings.json`, `vs-keybindings.json`)
- Helix editor configuration (`helix/`) with language server setup for TypeScript, JavaScript, and Python
- Comprehensive tmux configuration (`.tmux.conf`) with vim-tmux-navigator integration

## Architecture

### IntelliJ IDEA (IdeaVim)
- `.ideavimrc`: Vim emulation configuration for IntelliJ IDEA
  - Maps Vim motions to IntelliJ actions (`gd`, `K`, `<leader>rn`, `<leader>ca`, etc.)
  - Sets leader key to space
  - Enables surround and NERDTree plugins
  - Reload with `<leader>ir` or via Settings → Editor → Vim

### VS Code (VSCodeVim)
- `vs-settings.json`: VS Code Vim plugin settings
- `vs-keybindings.json`: Custom keybindings extending VSCodeVim

### Neovim
- `nvim/init.lua`: Bootstrap and entry point for the repo-owned Neovim configuration
- `nvim/lua/config/`: Options, keybindings, project pickers, LSP, formatting, terminal, and multicursor behavior
- `nvim/lua/plugins.lua`: lazy.nvim plugin specifications
- `nvim/lazy-lock.json`: Locked plugin revisions
- Uses native Neovim LSP configuration for TypeScript/JavaScript and Python
- `s` selects regex matches for simultaneous editing; `<C-v>` remains native visual-block editing

### Helix
- `helix/config.toml`: Editor settings (transparent theme, relative line numbers)
- `helix/languages.toml`: Language server configuration
  - TypeScript/JavaScript: `typescript-language-server` + Biome
  - Python: `pyright` + `ruff`
- `helix/themes/transparent.toml`: Custom transparent color theme

### Tmux Configuration (`.tmux.conf`)
- **Prefix Key**: `Ctrl+Space` (matches IntelliJ/VS Code leader key)
- **Plugin Manager**: TPM (Tmux Plugin Manager) - plugins defined at bottom of file
- **Key Plugin**: `christoomey/vim-tmux-navigator` - enables seamless Ctrl+h/j/k/l navigation between tmux panes and editor splits
- **Pane Resizing**: Uses uppercase `H/J/K/L` (without Ctrl) to avoid conflicts with vim-tmux-navigator
- **Status Bar**: Displays hostname, day, date, and time in 12-hour AM/PM format (e.g., "hostname Sun Nov 9 4:52 PM")

## Common Keybindings (Space is Leader)

These keybindings are consistent across IntelliJ IDEA, VS Code, Helix, and Neovim:

### File Navigation
- `<leader>ff`: Find files
- `<leader>fs`: Global text search
- `<leader>fb`: Find buffers / recent files
- `<C-p>`: Recent files (IntelliJ) / command palette (VS Code)

### Buffer Management
- `<Tab>`: Next tab/buffer
- `<S-Tab>`: Previous tab/buffer
- `<leader>x`: Close current tab/buffer

### LSP/Code Actions
- `gd`: Go to definition / declaration
- `gD`: Go to type declaration
- `gi`: Go to implementation
- `gr`: Find references
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
- `s` (Neovim): Regex-select matches on the current line or visual selection
- visual `<leader>gr`: Find the selected text in the current file
- visual `<leader>s`: Replace all literal occurrences of the selected text in the current file

### Window Management
- `<C-h>`/`<C-l>`: Navigate between editor splits
- `<C-j>`/`<C-k>`: Navigate between editor splits
- `<leader>|` or `<leader>\`: Split vertically
- `<leader>-` or `<leader>_`: Split horizontally

### Terminal
- `<leader>tt`: Toggle terminal

## Development Workflow

### Testing Configuration Changes
1. Edit config files in the repository
2. Reload the config in the relevant tool:
   - IntelliJ: `<leader>ir` or Settings → Editor → Vim → Reload
   - VS Code: Changes to `vs-settings.json` apply automatically; keybindings reload on focus
   - Helix: Changes to `helix/` apply automatically on next launch
   - Neovim: Restart Neovim after config or plugin changes; run `:Lazy sync` for plugin updates
   - Tmux: `Ctrl+Space + r` from within tmux, or `tmux source-file ~/.tmux.conf`

### Modifying Keybindings
- IntelliJ IDEA: Edit `.ideavimrc`
- VS Code: Edit `vs-settings.json` under `vim.normalModeKeyBindings` or `vim.visualModeKeyBindings`
- Neovim: Edit `nvim/lua/config/keymaps.lua` or the relevant module under `nvim/lua/config/`
- Helix: Keybindings are built-in; for customizations, check the Helix docs
- Tmux: Edit `.tmux.conf`, then reload with `Ctrl+Space + r` or `tmux source-file ~/.tmux.conf`

### Modifying Tmux Configuration
1. Edit `.tmux.conf` in the repository
2. Reload config: `Ctrl+Space + r` from within tmux, or `tmux source-file ~/.tmux.conf` from terminal
3. For TPM plugin changes: Press `Ctrl+Space + I` (capital I) to install new plugins
4. **Important**: When modifying pane navigation or resizing, remember that `Ctrl+h/j/k/l` is reserved for vim-tmux-navigator. Use uppercase letters or other keys for pane operations.

## Configuration Conventions

- Leader key is always space across all editors
- Tmux prefix is `Ctrl+Space` to match editor leader key
- The actual config file is `.tmux.conf` (with dot) - this is what tmux loads from `~/.tmux.conf`
- Keep keybindings consistent across editor configs where possible

### Keybinding Conflict Prevention

When adding new keybindings, always check for conflicts:
1. **Reserved keys**:
   - `<C-h/j/k/l>`: Reserved for vim-tmux-navigator (window/pane navigation)
   - `<Tab>/<S-Tab>`: Used for buffer/tab navigation in normal mode
   - `<leader>d`: Delete without yanking (do NOT override)
   - `<leader>f`: Format document (LSP)
   - `<C-p>`: Find files / command palette

2. **Before adding a keybinding**: Search the existing config files to verify it's not already in use

## Symlink Setup

This repository is designed to be cloned and symlinked to standard config locations:
- `~/.ideavimrc` → `/path/to/neovim-config/.ideavimrc`
- `~/.tmux.conf` → `/path/to/neovim-config/.tmux.conf`
- `~/.config/Code/User/settings.json` → `/path/to/neovim-config/vs-settings.json`
- `~/.config/Code/User/keybindings.json` → `/path/to/neovim-config/vs-keybindings.json`
- `~/.config/helix` → `/path/to/neovim-config/helix`
- `~/.config/nvim` → `/path/to/neovim-config/nvim`

When modifying configs, edit the files in this repository - changes will automatically apply via symlinks.
