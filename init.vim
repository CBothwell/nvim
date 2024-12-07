call plug#begin('~/.local/share/nvim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'flazz/vim-colorschemes'
  Plug 'junegunn/fzf'
  Plug 'fatih/vim-go', { 'do' : ':GoUpdateBinaries' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'miikanissi/modus-themes.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'mfussenegger/nvim-lint'
  Plug 'rktjmp/lush.nvim'
  Plug 'folke/which-key.nvim'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'echasnovski/mini.icons'
  Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim'
  Plug '~/.config/nvim/bosswell'
call plug#end()

let mapleader = "\<space>"
set termguicolors
set cursorline

"colorscheme k1989
colorscheme bosswell
set background=dark

source ~/.config/nvim/lua/config.lua
source ~/.config/nvim/lua/lsp.lua
source ~/.config/nvim/lua/telescope-config.lua
source ~/.config/nvim/lua/treesitter-config.lua

"set updatetime=300
"set nobackup
"set nowritebackup
"set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

set hidden 
autocmd FileType netrw nnoremap q :bd<CR>

syntax on
" set rtp^="/Users/christopher/.opam/default/share/ocp-indent/vim"
set nu
set ruler 
filetype plugin on 
set tabstop=2 shiftwidth=2 expandtab 
au Filetype python setl et ts=4 sw=4
au FileType perl setl et ts=4 sw=4
au FileType fsharp setl et ts=4 sw=4
au FileType ml setl et ts=4 sw=4
au FileType re setl et ts=4 sw=4
au BufNewFile,BufRead *.webc set filetype=html

:command T NERDTree
