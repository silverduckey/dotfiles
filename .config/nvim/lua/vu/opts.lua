g                  = vim.g
o                  = vim.o
opt                = vim.opt
api                = vim.api
fn                 = vim.fn
lsp                = vim.lsp
keymap             = vim.keymap

g.mapleader        = " "
g.maplocalleader   = " "

o.timeout          = true
o.timeoutlen       = 300

opt.guicursor      =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait500-blinkoff500-blinkon500-Cursor/lCursor,sm:block-blinkwait500-blinkoff500-blinkon500"

opt.nu             = true
opt.relativenumber = true

opt.tabstop        = 4
opt.softtabstop    = 4
opt.shiftwidth     = 4
opt.expandtab      = true

opt.smartindent    = true

opt.wrap           = false

opt.swapfile       = false
opt.backup         = false
opt.undofile       = true

opt.hlsearch       = false
opt.incsearch      = true

opt.termguicolors  = true

opt.scrolloff      = 8
opt.signcolumn     = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

