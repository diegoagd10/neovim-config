" ========================================
" Vim Configuration
" Mirrors Neovim and VS Code Vim settings
" ========================================

" ========================================
" General Settings
" ========================================

" Leader key
let mapleader = " "
let maplocalleader = " "

" Line numbers
set number
set relativenumber

" Indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Disable line wrap
set nowrap

" File handling
set noswapfile
set nobackup
if has('persistent_undo')
  set undodir=~/.vim/undodir
  set undofile
endif

" Search settings
set nohlsearch
set incsearch
set ignorecase
set smartcase

" UI Settings
set termguicolors
set scrolloff=8
set signcolumn=yes
set updatetime=50
set colorcolumn=80

" Cursor settings
set guicursor=

" Enable mouse support
set mouse=a

" Clipboard settings
if has('clipboard')
  set clipboard=unnamedplus
endif

" Better command-line completion
set wildmenu
set wildmode=longest:full,full

" Show partial commands
set showcmd

" ========================================
" Key Mappings
" ========================================

" File explorer
nnoremap <leader>pv :Explore<CR>
nnoremap <leader>nt :Explore<CR>

" Format JSON with prettier (if available)
nnoremap <leader>fj :%!prettier --parser json<CR>

" Move selected lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Center screen on scroll
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Center screen on search
nnoremap n nzzzv
nnoremap N Nzzzv

" Copy to system clipboard
" Use native clipboard if available, otherwise use xclip/xsel
if has('clipboard')
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>Y "+Y
else
  " Fallback to xclip (Linux) or pbcopy (macOS) when clipboard not available
  if executable('xclip')
    vnoremap <leader>y :w !xclip -selection clipboard<CR><CR>
    nnoremap <leader>y :.w !xclip -selection clipboard<CR><CR>
    nnoremap <leader>Y :w !xclip -selection clipboard<CR><CR>
  elseif executable('xsel')
    vnoremap <leader>y :w !xsel --clipboard --input<CR><CR>
    nnoremap <leader>y :.w !xsel --clipboard --input<CR><CR>
    nnoremap <leader>Y :w !xsel --clipboard --input<CR><CR>
  elseif executable('pbcopy')
    vnoremap <leader>y :w !pbcopy<CR><CR>
    nnoremap <leader>y :.w !pbcopy<CR><CR>
    nnoremap <leader>Y :w !pbcopy<CR><CR>
  else
    " No clipboard support and no external tool available
    vnoremap <leader>y "+y
    nnoremap <leader>y "+y
    nnoremap <leader>Y "+Y
  endif
endif

" Delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Find and replace current word
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Tab navigation (using leader key to avoid conflict with window navigation)
nnoremap <leader>th :tabprevious<CR>
nnoremap <leader>tl :tabnext<CR>

" Window/Pane navigation with vim-tmux-navigator support
" These keybindings work seamlessly with tmux when using the vim-tmux-navigator plugin
" If not in tmux, they fall back to regular vim window navigation
if exists('$TMUX')
  " When in tmux, let tmux handle the navigation
  nnoremap <silent> <C-h> :silent !tmux select-pane -L<CR>:redraw!<CR>
  nnoremap <silent> <C-j> :silent !tmux select-pane -D<CR>:redraw!<CR>
  nnoremap <silent> <C-k> :silent !tmux select-pane -U<CR>:redraw!<CR>
  nnoremap <silent> <C-l> :silent !tmux select-pane -R<CR>:redraw!<CR>
else
  " When not in tmux, use regular vim window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
endif

" Split windows
nnoremap <leader>\| :vsplit<CR>
nnoremap <leader>\\ :vsplit<CR>
nnoremap <leader>- :split<CR>
nnoremap <leader>_ :split<CR>

" Window movement
nnoremap <leader>t\| <C-w>L
nnoremap <leader>t\\ <C-w>L
nnoremap <leader>t- <C-w>J
nnoremap <leader>t_ <C-w>J

" Close all splits except current
nnoremap <leader>us :only<CR>

" Toggle terminal (if terminal support available)
if has('terminal')
  nnoremap <leader>tt :terminal<CR>
elseif has('nvim')
  nnoremap <leader>tt :terminal<CR>
endif

" Comment line (requires vim-commentary or similar)
nnoremap <leader>cm :Commentary<CR>
vnoremap <leader>cm :Commentary<CR>

" ========================================
" LSP-like Mappings (requires plugins)
" ========================================

" Go to definition (with tags or LSP)
nnoremap gd <C-]>
nnoremap gD g<C-]>
nnoremap gi :tag <C-r><C-w><CR>
nnoremap gr :execute 'tag' expand('<cword>')<CR>

" Show hover (K is built-in)
" nnoremap K K

" Code actions (requires LSP plugin)
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>

" Format document
nnoremap <leader>rf gg=G<C-o><C-o>

" ========================================
" Plugin Settings (optional)
" ========================================

" If using vim-plug, fzf, or similar fuzzy finder:
" nnoremap <leader>ff :Files<CR>
" nnoremap <leader>fs :Rg<CR>
" nnoremap <C-p> :GFiles<CR>

" If using NERDTree:
" nnoremap <leader>nt :NERDTreeToggle<CR>

" ========================================
" Visual Settings
" ========================================

" Enable syntax highlighting
syntax enable

" Set color scheme (uncomment your preferred scheme)
" colorscheme desert
" colorscheme molokai
" colorscheme gruvbox
" colorscheme onedark

" Highlight yanked text (Vim 8.0.1394+)
if exists('##TextYankPost')
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250}
  augroup END
endif

" ========================================
" File Type Settings
" ========================================

filetype plugin indent on

" ========================================
" Status Line
" ========================================

set laststatus=2
set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" ========================================
" Auto Commands
" ========================================

" Remove trailing whitespace on save
augroup TrimWhitespace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Return to last edit position when opening files
augroup LastPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" ========================================
" Notes
" ========================================
" This configuration mirrors:
" - lua/diegoagd/core/settings.lua
" - lua/diegoagd/core/keymaps.lua
" - vs-settings.json
" - vs-keybindings.json
"
" For full LSP support, install:
" - vim-lsp or coc.nvim
"
" For fuzzy finding, install:
" - fzf.vim or ctrlp.vim
"
" For file explorer enhancements:
" - NERDTree or vim-vinegar
"
" For auto-pairs:
" - auto-pairs or vim-autopairs
