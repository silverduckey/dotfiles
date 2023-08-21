let mapleader="\<space>"
let maplocalleader="\<space>"

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

set nohlsearch
set incsearch

set termguicolors

set scrolloff=8
set signcolumn=yes
set isfname:("@-@")

set updatetime=50

set colorcolumn=80

set wildmenu
set wildmode=full

set smartcase

set noshowmode

set laststatus=2

syntax on

if !has('gui_running')
  set t_Co=256
endif

call plug#begin('$HOME/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'vifm/vifm.vim'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
call plug#end()

let g:nord_uniform_diff_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

let g:floaterm_width=0.9
let g:floaterm_height=0.9

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

colorscheme nord

nnoremap <leader>. <cmd>Vifm<cr>

nnoremap <leader>gs <cmd>FloatermNew lazygit<cr>

nnoremap <leader>ff <cmd>Files<cr>
nnoremap <leader>fb <cmd>Buffers<cr>
nnoremap <leader>fg <cmd>Rg<cr>
nnoremap <leader>fh <cmd>Helptags<cr>
nnoremap <leader>fr <cmd>History<cr>
nnoremap <leader>fk <cmd>Maps<cr>
