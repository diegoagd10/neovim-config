# Tmux Setup

This repository includes a comprehensive tmux configuration with vim-style keybindings and seamless Neovim integration.

## Installation

### 1. Install Tmux

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install tmux
```

**macOS:**
```bash
brew install tmux
```

**Fedora:**
```bash
sudo dnf install tmux
```

### 2. Install the Configuration

Copy the tmux configuration to your home directory:
```bash
cp tmux.conf ~/.tmux.conf
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
