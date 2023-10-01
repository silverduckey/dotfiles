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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('$HOME/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'nanotee/zoxide.vim'
Plug 'mbbill/undotree'
call plug#end()

let g:nord_uniform_diff_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
colorscheme nord

let g:lf_map_keys = 0
let g:lf_replace_netrw = 1
nnoremap <leader>. <cmd>Lf<cr>

let g:floaterm_title=""
let g:floaterm_width=0.9
let g:floaterm_height=0.9
nnoremap <leader>gs <cmd>FloatermNew lazygit<cr>

nnoremap <leader>wf <cmd>Files<cr>
nnoremap <leader>wb <cmd>Buffers<cr>
nnoremap <leader>wg <cmd>Rg<cr>
nnoremap <leader>h <cmd>Helptags<cr>
nnoremap <leader>o <cmd>History<cr>

let g:lightline = {
            \ 'colorscheme': 'nord',
            \ }
let g:lightline.active = {
            \ 'left': [ [ 'mode', 'paste' ],
            \           [],
            \           [ 'absolutepath', 'modified', 'readonly', ] ],
            \ }

nnoremap <leader>cd <cmd>Zi<cr>

nnoremap <leader>u <cmd>UndotreeToggle<cr>
