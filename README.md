# Editor & Terminal Configuration

Unified Vim-style setup for **Neovim**, **IntelliJ IDEA**, **VS Code**, **Helix**, and **tmux**.

## Quick Start

```bash
git clone https://github.com/yourusername/neovim-config.git ~/Projects/neovim-config
cd ~/Projects/neovim-config

# Back up existing configs
[ -f ~/.ideavimrc ] && mv ~/.ideavimrc ~/.ideavimrc.backup
[ -f ~/.tmux.conf ] && mv ~/.tmux.conf ~/.tmux.conf.backup
[ -f ~/.config/Code/User/settings.json ] && mv ~/.config/Code/User/settings.json.backup
[ -f ~/.config/Code/User/keybindings.json ] && mv ~/.config/Code/User/keybindings.json.backup
[ -d ~/.config/helix ] && mv ~/.config/helix ~/.config/helix.backup
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup

# Symlink
ln -s ~/Projects/neovim-config/.ideavimrc ~/.ideavimrc
ln -s ~/Projects/neovim-config/.tmux.conf ~/.tmux.conf
ln -s ~/Projects/neovim-config/vs-settings.json ~/.config/Code/User/settings.json
ln -s ~/Projects/neovim-config/vs-keybindings.json ~/.config/Code/User/keybindings.json
ln -s ~/Projects/neovim-config/helix ~/.config/helix
ln -s ~/Projects/neovim-config/nvim ~/.config/nvim
mkdir -p ~/.vim/undodir
```

Then install **IdeaVim** (IntelliJ → Settings → Plugins), **VSCodeVim** (`code --install-extension vscodevim.vim`), **TPM** (`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`), and **language servers** (`npm i -g typescript-language-server biome && pip install pyright ruff`). Neovim plugins install automatically on first launch through lazy.nvim. Open tmux and press `Ctrl+Space + I` to install tmux plugins.

## Set Neovim as Default Editor

Add to `~/.zshrc`:

```bash
export EDITOR="nvim"
export VISUAL="nvim"
```

Then reload: `source ~/.zshrc`.

## Files

| File | Purpose |
| --- | --- |
| `.ideavimrc` | IntelliJ IDEA Vim plugin config |
| `vs-settings.json`, `vs-keybindings.json` | VS Code Vim config |
| `helix/` | Helix editor config + language servers |
| `nvim/` | Neovim config, plugins, LSP, formatting, and keybindings |
| `.tmux.conf` | tmux with vim-style bindings |
| `CLAUDE.md` | Internal dev notes |

## Keybindings

Leader is `Space` everywhere. Tmux prefix is `Ctrl+Space`.

| Action | Keybinding |
| --- | --- |
| Find files | `<leader>ff` |
| Search text | `<leader>fs` |
| Recent files | `<C-p>` |
| Next / prev tab | `<Tab>` / `<S-Tab>` |
| Close tab | `<leader>x` |
| Go to definition | `gd` |
| Find references | `gr` |
| Hover docs | `K` |
| Rename | `<leader>rn` |
| Code actions | `<leader>ca` |
| Format | `<leader>f` |
| Regex multi-edit | `s` |
| Column insert / append | `<C-v>` then `I` / `A` |
| Find visual selection in current file | visual `<leader>gr` |
| Replace visual selection in current file | visual `<leader>s` |
| Move line down/up (visual) | `J` / `K` |
| Yank to clipboard | `<leader>y` |
| Delete without yank | `<leader>d` |
| Replace current word | `<leader>s` |
| Navigate splits | `<C-h/j/k/l>` |
| Split vertical / horizontal | `<leader>\|` / `<leader>-` |
| Toggle terminal | `<leader>tt` |

### Tmux Highlights

- `Ctrl+Space r` — reload config
- `Ctrl+Space |` / `-` — split pane
- `Ctrl+h/j/k/l` — seamless pane jump (across editors via vim-tmux-navigator)
- `Ctrl+Space H/J/K/L` — resize pane
- `Ctrl+Space [` — enter copy mode (`v` select, `y` yank)

## Reload Configs

- **IntelliJ**: `<leader>ir` or Settings → Editor → Vim → Reload
- **VS Code**: settings apply on focus
- **Helix**: changes apply on next launch
- **Neovim**: restart after config or plugin changes
- **tmux**: `Ctrl+Space r` or `tmux source-file ~/.tmux.conf`

## Troubleshooting

- **tmux plugins**: ensure TPM is at `~/.tmux/plugins/tpm`, then `Ctrl+Space + I`
- **Colors**: check `echo $TERM` shows `xterm-256color` or similar
- **Clipboard**: `sudo apt install xclip`
- **Neovim health**: run `:checkhealth` and `:ConformInfo`
