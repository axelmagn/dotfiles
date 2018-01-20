
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
Plugin 'christoomey/vim-tmux-navigator' " easy tmux navigation

" color schemes
Plugin 'tomasr/molokai'                     " Molokai
Plugin 'vim-airline/vim-airline-themes'     " airline themes

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
