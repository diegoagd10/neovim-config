# Neovim, Vim & Tmux Configuration

This repository contains a modern Neovim configuration with LSP support, autocompletion, and fuzzy finding, a pure Vim configuration that mirrors the Neovim keybindings, and a comprehensive tmux configuration featuring vim-style keybindings and seamless editor integration.

**Quick Setup:** Clone this repository and symlink the configurations to keep them in sync automatically!

## Quick Start

Clone this repository and symlink all configurations at once:

```bash
# Clone the repository
git clone https://github.com/yourusername/neovim-config.git ~/Projects/neovim-config
cd ~/Projects/neovim-config

# Backup existing configs
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup

# Create symlinks
ln -s ~/Projects/neovim-config ~/.config/nvim
ln -s ~/Projects/neovim-config/.vimrc ~/.vimrc
ln -s ~/Projects/neovim-config/tmux.conf ~/.tmux.conf

# Create required directories
mkdir -p ~/.vim/undodir
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Start Neovim to install plugins (or Vim)
nvim
# Press Ctrl+Space + I in tmux to install tmux plugins
```

For detailed setup instructions, see the individual sections below.

## Repository Structure

**Neovim Configuration:**
- `init.lua` - Neovim entry point
- `lazy-lock.json` - Plugin versions lockfile
- `lua/diegoagd/` - All Neovim Lua configuration
  - `core/` - Core settings and keybindings
  - `plugins/` - Plugin configurations (auto-loaded by Lazy.nvim)
  - `lazy.lua` - Lazy.nvim plugin manager setup

**Cross-Editor Vim Configurations:**
- `.vimrc` - Standard Vim configuration
- `.ideavimrc` - IntelliJ IDEA Vim plugin configuration
- `vs-settings.json` - VS Code Vim settings
- `vs-keybindings.json` - VS Code Vim keybindings

**Tmux Configuration:**
- `tmux.conf` - Tmux configuration with vim-style bindings

**Documentation:**
- `CLAUDE.md` - Development guide for working with this config
- `README.md` - This file

---

# Neovim Setup

This is a fully-configured Neovim setup using Lua with the Lazy.nvim plugin manager, LSP support, and cross-editor keybindings.

## Installation

### 1. Install Neovim

**Latest Stable via PPA (Recommended):**
```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
```

**Default Repository:**
```bash
sudo apt update
sudo apt install neovim
```
*Note: This may install an older version.*

**Verify Installation:**
```bash
nvim --version
```

### 2. Install This Configuration

**Backup existing configuration (if any):**
```bash
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

**Install the configuration:**

The Neovim configuration consists of:
- `init.lua` - Entry point
- `lazy-lock.json` - Plugin lockfile
- `lua/` - All Lua configuration files

**Recommended: Symlink to keep in sync with this repo**
```bash
# Backup existing config if you have one
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup

# Create symlink to this repository
ln -s /path/to/this/neovim-config ~/.config/nvim

# Example if this repo is at ~/Projects/neovim-config:
# ln -s ~/Projects/neovim-config ~/.config/nvim
```

**Alternative: Copy files from this repository**
```bash
# Navigate to this repository directory
cd /path/to/neovim-config

# Create the Neovim config directory
mkdir -p ~/.config/nvim

# Copy configuration files
cp init.lua ~/.config/nvim/
cp lazy-lock.json ~/.config/nvim/
cp -r lua ~/.config/nvim/
```

### 3. Install Plugins and LSP Servers

Start Neovim:
```bash
nvim
```

Lazy.nvim will automatically:
1. Bootstrap itself on first launch
2. Install all configured plugins
3. Mason will auto-install LSP servers (TypeScript, Angular, Lua, HTML, CSS, Java)
4. Auto-install formatters and linters (Prettier, ESLint, Stylua)

This may take a few minutes on first launch. Once complete, restart Neovim.

### 4. Verify Installation

Check that everything is installed correctly:

**Check Lazy.nvim plugins:**
```vim
:Lazy
```
All plugins should show as installed (green checkmarks).

**Check Mason LSP servers:**
```vim
:Mason
```
You should see: `ts_ls`, `angularls`, `lua_ls`, `html`, `cssls`, `jdtls` installed.

**Test a keybinding:**
Press `Space` (leader key) then `ff` - Telescope file finder should open.

## Key Features

- **Plugin Manager**: Lazy.nvim for fast, lazy-loaded plugins
- **LSP Support**: Full Language Server Protocol integration with auto-installation
- **Autocompletion**: nvim-cmp with LSP, snippets, buffer, and path sources
- **Fuzzy Finding**: Telescope for file and text search
- **Consistent Keybindings**: Same keybindings across Neovim, IntelliJ IDEA, and VS Code
- **Modern UI**: Transparent floating windows, indent guides, and color schemes

## Quick Start Keybindings

**Leader key:** `Space`

### Essential Commands
- `<leader>ff` - Find files
- `<leader>fs` - Search text in project
- `gd` - Go to definition
- `K` - Show documentation
- `<leader>ca` - Code actions
- `<leader>f` - Format document
- `<leader>rn` - Rename symbol

See [CLAUDE.md](CLAUDE.md) for complete keybinding reference.

## Managing Plugins

Check plugin status:
```vim
:Lazy
```

Update all plugins:
```vim
:Lazy update
```

## Troubleshooting

### LSP Servers Not Working
Check Mason installation status:
```vim
:Mason
```
Use `i` to install missing servers, `u` to update.

### Plugins Not Loading
Clean plugin cache and reinstall:
```bash
rm -rf ~/.local/share/nvim
nvim  # Restart to reinstall everything
```

---

# Vim Setup

This repository includes a pure Vim configuration (`.vimrc`) that mirrors the Neovim and VS Code Vim keybindings for consistency across all editors.

## Installation

### 1. Install Vim

```bash
sudo apt update
sudo apt install vim
```

### 2. Symlink the Configuration

**Recommended: Symlink to keep in sync with this repo:**
```bash
# Backup existing .vimrc if you have one
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup

# Create symlink from this repository
ln -s /path/to/neovim-config/.vimrc ~/.vimrc

# Example if this repo is at ~/Projects/neovim-config:
# ln -s ~/Projects/neovim-config/.vimrc ~/.vimrc
```

**Alternative: Copy the file:**
```bash
cp /path/to/neovim-config/.vimrc ~/.vimrc
```

### 3. Create Undo Directory

```bash
mkdir -p ~/.vim/undodir
```

### 4. Verify Installation

Start Vim and verify the configuration is loaded:
```bash
vim
# Press Space (leader key) then type :echo mapleader
# Should display a space character
```

## Key Features

- **Consistent Keybindings**: Same as Neovim and VS Code configurations
- **No Plugins Required**: Core functionality works out of the box
- **Plugin-Ready**: Includes commented sections for popular plugins (fzf, NERDTree, LSP)
- **Persistent Undo**: Undo history saved between sessions
- **Quality of Life**: Auto-trim whitespace, yank highlighting, return to last position

## Optional Plugins

For enhanced functionality similar to Neovim, consider installing:

**Plugin Manager (vim-plug):**
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

**Recommended Plugins:**
- **fzf.vim** - Fuzzy finding (like Telescope)
- **coc.nvim** or **vim-lsp** - LSP support
- **NERDTree** - File explorer
- **vim-commentary** - Easy commenting
- **auto-pairs** - Auto-close brackets

See `.vimrc` comments for plugin configuration examples.

## Troubleshooting

### Clipboard Not Working

If `<leader>y` doesn't copy to system clipboard, your Vim might not have clipboard support.

**Check clipboard support:**
```bash
vim --version | grep clipboard
# Look for +clipboard (supported) or -clipboard (not supported)
```

**Solution 1: Install Vim with clipboard support (Recommended)**
```bash
sudo apt install vim-gtk3
```

**Solution 2: Use xclip (already configured in .vimrc)**
```bash
sudo apt install xclip
```

The `.vimrc` automatically detects and uses `xclip`/`xsel` if native clipboard support is unavailable.

---

# Tmux Setup

This repository includes a comprehensive tmux configuration with vim-style keybindings and seamless Neovim integration.

## Installation

### 1. Install Tmux

```bash
sudo apt update
sudo apt install tmux
```

### 2. Install the Configuration

**Recommended: Symlink to keep in sync with this repo:**
```bash
# Backup existing .tmux.conf if you have one
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup

# Create symlink from this repository
ln -s /path/to/neovim-config/tmux.conf ~/.tmux.conf

# Example if this repo is at ~/Projects/neovim-config:
# ln -s ~/Projects/neovim-config/tmux.conf ~/.tmux.conf
```

**Alternative: Copy the file:**
```bash
cp /path/to/neovim-config/tmux.conf ~/.tmux.conf
```

### 3. Install TPM (Tmux Plugin Manager)

The configuration uses TPM to manage plugins. Install it with:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Start Tmux and Install Plugins

Start a new tmux session:
```bash
tmux
```

Install the plugins by pressing: `Ctrl+Space` + `I` (capital I)

The following plugins will be installed:
- **tmux-sensible**: Sensible default settings
- **vim-tmux-navigator**: Seamless navigation between Vim and tmux panes

## Key Features

- **Prefix Key**: `Ctrl+Space` (consistent with Neovim leader key)
- **Mouse Support**: Enabled for scrolling, clicking, and pane resizing
- **Vim-style Keybindings**: Navigation and copy mode use vim motions
- **True Color Support**: Full 24-bit color support
- **Smart Window/Pane Numbering**: Starts at 1 (not 0) and auto-renumbers
- **Large Scrollback**: 5000 lines of history

## Essential Keybindings

### General
- `Ctrl+Space` + `r` - Reload tmux configuration
- `Ctrl+Space` + `Space` - Toggle to previous window
- `Ctrl+Space` + `Ctrl+Space` - Toggle to previous session

### Window Management
- `Ctrl+Space` + `c` - Create new window (in current directory)
- `Ctrl+Space` + `<` - Move window left in list
- `Ctrl+Space` + `>` - Move window right in list
- `Ctrl+Space` + `,` - Rename current window
- `Ctrl+Space` + `x` - Kill current pane
- `Ctrl+Space` + `e` or `X` - Kill current window

### Pane Navigation
**Seamless Navigation (via vim-tmux-navigator plugin):**
- `Ctrl+h` - Move to left pane (works across tmux and Neovim)
- `Ctrl+j` - Move to pane below (works across tmux and Neovim)
- `Ctrl+k` - Move to pane above (works across tmux and Neovim)
- `Ctrl+l` - Move to right pane (works across tmux and Neovim)

Note: These work **without** the prefix key and seamlessly navigate between tmux panes and Neovim splits!

### Pane Management
- `Ctrl+Space` + `|` or `\` - Split pane vertically
- `Ctrl+Space` + `-` or `_` - Split pane horizontally
- `Ctrl+Space` + `H/J/K/L` - Resize pane (vim directions)
- `Ctrl+Space` + `b` - Break pane into new window
- `Ctrl+Space` + `C` - Join pane from another window (horizontal)
- `Ctrl+Space` + `M` - Join pane from another window (vertical)

### Marked Pane Navigation
- `Ctrl+Space` + `m` - Mark current pane
- `Ctrl+Space` + `` ` `` - Jump to marked pane

### Copy Mode (Vim-style)
- `Ctrl+Space` + `[` - Enter copy mode
- `v` - Begin selection
- `y` - Yank selection to system clipboard
- `Ctrl+v` - Rectangle selection
- `q` or `Escape` - Exit copy mode

### Other Useful Commands
- `Ctrl+Space` + `S` - Synchronize panes (send commands to all panes)

## Reloading Configuration

After making changes to `~/.tmux.conf`:

**Method 1 (from within tmux):**
```bash
Ctrl+Space + r
```

**Method 2 (from terminal):**
```bash
tmux source-file ~/.tmux.conf
```

**Method 3 (for UI changes that don't apply with reload):**
```bash
# Detach from session: Ctrl+Space + d
tmux kill-server
tmux new -s your-session-name
```

## Troubleshooting

### Plugins Not Working
1. Ensure TPM is installed: `ls ~/.tmux/plugins/tpm`
2. Press `Ctrl+Space` + `I` (capital I) to install plugins
3. Restart tmux

### Colors Not Displaying Correctly
Ensure your terminal supports 256 colors and true color:
```bash
echo $TERM  # Should show something like "xterm-256color" or "screen-256color"
```

### Clipboard Not Working
Install `xclip` for clipboard support:
```bash
sudo apt install xclip  # Ubuntu/Debian
```

# References
- https://www.vim-hero.com/
- https://builtin.com/articles/tmux-config
- https://www.youtube.com/watch?v=w7i4amO_zaE&list=LL&index=3&t=435s
- https://monsterlessons-academy.com/posts/neovim-complete-setup-setting-up-neovim-from-scratch
- https://www.jetbrains.com/help/idea/using-product-as-the-vim-editor.html
- https://dev.to/ansonh/10-vs-code-vim-tricks-to-boost-your-productivity-1b0n#7-file-explorer-keybindings
