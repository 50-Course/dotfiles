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
set laststatus=2
set ruler
set nobackup
set nowritebackup
set hidden


let g:coc_disable_startup_warning = 1
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

if has('ide')
    " global settings
    set ideamarks
    set ideaput

    " mappings for jetbrains editors, such as intellij, android studio and
    " pycharm
    map gf <Action>(GotoFile)
    map <leader>b <Action>(Switcher)
endif

" I just can shake the fillig of using vim in vscode sometimes
if has('code')

endif

" -----------------------------------------------------
" PLUGINS ----------------------------------------- {{{

call plug#begin('~/.vim/plugged')


    Plug 'christoomey/vim-tmux-navigator'
    Plug 'dense-analysis/ale'
    Plug 'preservim/nerdtree'
    Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'neoclide/coc-tabnine', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}  
    Plug 'davidhalter/jedi-vim'
    Plug 'vim-test/vim-test'

call plug#end()

runtime coc-init.vim

" }}}

" MAPPINGS ---------------------------------------- {{{
" Mappings

nnoremap <Space> <Nop>
let mapleader=" "
inoremap jj <esc>
inoremap jk <esc>
vnoremap jk <esc>
xnoremap jk <esc>
inoremap <esc> <nop>
nnoremap <silent><C-f> <Cmd>!tmux neww tmux-sess-man<CR>
nmap <Leader><Leader> <Cmd>source %<CR>
nmap <silent><Leader>x <Cmd>!chmod +x %<CR>
nmap <Leader>pv <Cmd>Vex<CR>
nmap <leader>f :Rg<CR>
nnoremap <C-c> <Cmd>q<CR>
nnoremap <Leader>cb <Cmd>q!<CR>
nnoremap <Leader>w <Cmd>w<CR>

" Use system clipboards instead of Vim's built-in clipboard
 nnoremap <Leader>y "+Y
 vnoremap <Leader>y "+Y
 nnoremap <Leader>d "_d
 vnoremap <Leader>d "_d
 nnoremap <Leader>p "+P



" }}}

" STATUS LINE ------------------------------------- {{{
" Status bar code goes here.

" }}}
"

