" GENERAL

" Do NOT ensure 'vi' compatability (would turn off 'vim' features)
set nocompatible

" Set encoding.
set encoding=utf-8

" Automatically reload files from disk on change.
set autoread

" Configure buffers to be able to exist in background.
set hidden

" Restore last cursor position & marks on open.
au BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Increase :cmdline history size.
set history=1000
au FocusGained,BufEnter * :checktime

" Turn off swap files.
set noswapfile

" Turn off backup.
set nobackup
set nowritebackup

" Define global leader key.
nnoremap <SPACE> <Nop>
let mapleader=" "

" Define local leader key.
" let maplocalleader="\<tab>"

" Source `init.vim` with hotkey
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Move vertically by visual line. 
" Needs a different command for vscode-neovim (why?).
if exists('g:vscode')
  nmap j gj
  nmap k gk
else
  nnoremap j gj
  nnoremap k gk
endif

" ===============================================

" Activate "filetype detection", "plugin", and "indent".

" Opening a file, Vim will try to recognize the filetype and set the 'filetype' option.
" It also triggers the FileType event, which can be used to set the syntax higlighting etc.
filetype on

" This setting loads the "<filetype>.vim" file in 'runtimepath' (ie "html.vim" or "html/foobar.vim")
filetype plugin on

" This setting loads the "indent.vim" file in 'runtimepath'.
filetype indent on


" Make sure plugin manager (junnegun/vim-plug) is installed.
if empty(glob("$XDG_DATA_HOME/nvim/site/autoload/plug.vim"))
    silent !curl -fLo
    \ "$XDG_DATA_HOME/nvim/site/autoload/plug.vim" --create-dirs
    \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

" Auto-install plugins.
" Not sure if this is part of Vinc's auto rice, ie the $NVIMRC variable..
" if empty(glob("$XDG_DATA_HOME/nvim/plugged"))
"         autocmd VimEnter * PlugInstall --sync | source $NVIMRC
" endif

" Define list of plugins to install.
call plug#begin('$XDG_DATA_HOME/nvim/plugged')
" call plug#begin('$HOME/.local/share/nvim/plugged')

    " Highlight yanked portions of text.
    " Plug 'machakann/vim-highlightedyank'
    
    " NERDTree
    Plug 'scrooloose/nerdtree'
    " Plug 'jistr/vim-nerdtree-tabs' " -> same NERDTree across vim-tabs
    " Plug 'ivalkeen/nerdtree-execute' " -> m-x in NERDTree to quick-open
    Plug 'Xuyuanp/nerdtree-git-plugin' " -> git-status in NERDTree

    " Enable markdown folding by section
    Plug 'masukomi/vim-markdown-folding', {'for': 'markdown'}

    " Do everything git related from inside vim
    Plug 'tpope/vim-fugitive'
    " Enable display of git status in sign-column
    Plug 'airblade/vim-gitgutter'

    " Make all words on screen available for auto-complete.
    Plug 'wellle/tmux-complete.vim'
    " Treat TMUX- & vim-panes equally.
    Plug 'christoomey/vim-tmux-navigator'

    " Solarized theme
    Plug 'altercation/vim-colors-solarized'

    " Minimalist editor. (Goyo)
    Plug 'junegunn/goyo.vim'

    " Limelight -> Highlight only relevant sections
    Plug 'junegunn/limelight.vim'

    " Various nice plugins by tpope speeding up vim workflow
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-markdown'

call plug#end()

" Show typed commands in lower-right corner
set showcmd

" Specify colorscheme
" colorscheme solarized

" Enable markdown fenced syntax highlighting
let g:markdown_fenced_languages = ['html', 'python', 'py=python', 'yaml', 'sql', 'bash=sh', 'sh']

" Enable dark-mode
set background=dark

" Define keyboard shortcuts to toggle light/dark mode.
" DISABLED, dark background clashes with transparent Alacritty window
" map <leader>ml :set bg=light<CR>
" map <leader>md :set bg=dark<CR>

" Always have at least 10 lines above/below the cursor.
set scrolloff=10

" Use Iosevka Nerd Font in GUI-Vim.
set guifont="Iosevka Nerd Font"

" Remove stuck search match highlighting.
nnoremap <leader>/ :nohlsearch<CR>

" Use relative line numbers.
set number relativenumber

" Deactivate tildes on the left side of the screen.
highlight Normal ctermbg=None
highlight EndOfBuffer ctermfg=0 ctermbg=None

" Don't show vim-mode.
set noshowmode

" Don't show current location in file.
set noruler

" Set colors of statusline. (invisible)
hi StatusLine ctermbg=None ctermfg=black

" Turn on syntax highlighting.
syntax on

" Highlight matching brackets.
" - NOTE: Switch between them with %
set showmatch
set matchpairs+=<:>

" Activate mouse.
" set mouse=a

" Make intra-file search case-insensitive, except if capital letters are entered.
set ignorecase smartcase

" Switch between buffers.
map gn :bn<CR>
map gp :bp<CR>

" Move `~/.viminfo` to `$XDG_DATA_HOME/nvim/.viminfo`
" DISABLED nvim uses `.nvim`, which has not yet appeard in $HOME
"set viminfo+=n$XDG_DATA_HOME/viminfo

" Needed for `vim-markdown-fold`
if has("autocmd")
  filetype plugin indent on
endif

let g:markdown_folding = 1
let g:markdown_fold_override_foldtext = 1

" Workaround for vim 8.2 to get text in folded headers.
function FoldTextWorkaround()
    let level = HeadingDepth(v:foldstart)
    let indent = repeat('#', level)
    let title = substitute(getline(v:foldstart), '^#\+\s*', '', '')
    let foldsize = (v:foldend - v:foldstart)
    let linecount = '['.foldsize.' line'.(foldsize>1?'s':'').']'
    return indent.' '.title.' '.linecount
endfunction
if g:markdown_fold_override_foldtext
  "let &l:foldtext = s:SID() . 'FoldText()'
  setlocal foldtext=FoldTextWorkaround() 
endif

" NERDTree keybinds
" Toggle NERDTree
" map <leader>n :NERDTreeToggle<CR>
" map <leader>n :NERDTreeFocus<CR>
map <leader>o :NERDTreeToggle<CR>
map <leader>w <C-w><C-w>
" Navigate windows with <leader>+hjkl
map <leader>h <C-w><left>
map <leader>j <C-w><down>
map <leader>k <C-w><up>
map <leader>l <C-w><right>

" TODO: continue checking Vinc's config.

