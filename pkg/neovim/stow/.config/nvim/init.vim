
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Configuration
"
" Author: Axel Magnuson
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

call plug#begin("~/.local/share/nvim/plug")

Plug 'tpope/vim-sensible'               " Tim Pope's sensible vim configs
Plug 'Shougo/denite.nvim'               " unite buffer
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " completion
Plug 'christoomey/vim-tmux-navigator' " easy tmux navigation

" color schemes
Plug 'tomasr/molokai'                     " Molokai
Plug 'vim-airline/vim-airline-themes'     " airline themes

call plug#end()
