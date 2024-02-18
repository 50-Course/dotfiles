"

" Disable compatibiity with vi
set nocompatible

" Enable autodetection of file type
filetype on

" Load plugins for file
filetype plugin on

" Load an indent file for detected file type
filetype indent on

set showmode
set nohlsearch
set autoindent
set scrolloff=8
set relativenumber
set incsearch
set splitbelow
set noswapfile
set clipboard=unnamedplus

" Set tab with to 4 columns
set tabstop=4 softtabstop=4

" Use space characters instead of tabs
set expandtab

" Do not wrap lines
set nowrap

" Set smart indenttion
set smartindent

" Set shift width
set shiftwidth=4

" Turn on syntax highlighting
syntax on

" Show line numbers
set number

" AUTOCOMPLETION
" Enable autocompletion
set wildmenu

" Make wildmenu behave like bash completion
set wildmode=list:longest

" Ignore these files in autocomplete
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx,**/node_modules



" Others
map mapleader <Space>

" Open file explorer with simple command
nnoremap <leader>pv :Vex<CR>

if has('ide')
    " global settings
    set ideamarks
    set ideaput

    " mappings for jetbrains editors, such as intellij, android studio and
    " pycharm
    map gf <Action>(GotoFile)
    map <leader>b <Action>(Switcher)
endif

" -----------------------------------------------------
" PLUGINS ----------------------------------------- {{{

call plug#begin('~/.vim/plugged')



    Plug 'dense-analysis/ale'
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
    Plug 'preservim/nerdtree'

    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'neoclide/coc-tabnine', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'davidhalter/jedi-vim'

call plug#end()

runtime coc-init.vim

" }}}

" MAPPINGS ---------------------------------------- {{{

" Mappings
inoremap jj <esc>
inoremap jk <esc>
vnoremap jk <esc>
xnoremap jk <esc>
inoremap <esc> <nop>


" }}}

" STATUS LINE ------------------------------------- {{{
" Status bar code goes here.

" }}}
"

