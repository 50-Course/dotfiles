"

" BASICS

" Disable compatibiity with vi
set nocompatible

" Enable autodetection of file type
filetype on

" Load plugins for file
filetype plugin off

" Load an indent file for detected file type
filetype indent on


set showmode
set nohlsearch
set autoindent

" Set tab with to 4 columns
set tabstop=4

" Use space characters instead of tabs
set expandtab

" Do not wrap lines
set nowrap

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
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx


" -----------------------------------------------------
" PLUGINS ----------------------------------------- {{{

call plug#begin('~/.vim/plugged')

    Plug 'dense-analysis/ale'
    Plug 'preservim/nerdtree'

call plug#end()

" }}}

" MAPPINGS ---------------------------------------- {{{

" Mappings
inoremap jj <esc>
inoremap <esc> <nop>


" }}}

" STATUS LINE ------------------------------------- {{{
" Status bar code goes here.

" }}}
"

