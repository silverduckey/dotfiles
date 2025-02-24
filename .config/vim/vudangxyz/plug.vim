if empty(glob("$XDG_CONFIG_HOME/vim/autoload/plug.vim"))
    silent !curl -fLo $XDG_CONFIG_HOME/vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
autocmd VimEnter * if len(filter(values(g:plugs), "!isdirectory(v:val.dir)"))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif
call plug#begin()
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'chriszarate/yazi.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'nanotee/zoxide.vim'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree'
call plug#end()

colorscheme catppuccin_mocha

nnoremap <leader>. :Yazi<CR>

nnoremap <leader>wf :Files<CR>
nnoremap <leader>gf :GitFiles<CR>
nnoremap <leader>wb :Buffers<CR>
nnoremap <leader>wg :RG<CR>
nnoremap <leader>h :Helptags<CR>
nnoremap <leader>cd :Zi<CR>

let g:lightline = {
            \ 'colorscheme': 'catppuccin_mocha',
            \ }

nnoremap <leader>u :UndotreeToggle<CR>
