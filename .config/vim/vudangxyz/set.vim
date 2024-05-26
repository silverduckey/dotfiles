let mapleader=" "
let maplocalleader=" "

set timeout
set timeoutlen=300

let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[1 q"

set nu
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set nowrap

set noswapfile
set nobackup
set undofile
set undodir=$XDG_CONFIG_HOME/vim/undo

set nohlsearch
set incsearch

set termguicolors

set scrolloff=8
set signcolumn=yes
set isfname+=("@-@")

set updatetime=50

set colorcolumn=80

set wildmenu
set wildmode=full

set smartcase

set noshowmode

set laststatus=2

set mouse=a

set nocompatible

set noshowmode

syntax on
