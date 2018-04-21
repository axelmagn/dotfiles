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

" baseline configuration
Plug 'tpope/vim-sensible'               " Tim Pope's sensible vim configs

" functionality
Plug 'Shougo/denite.nvim'                                       " unite buffer
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " completion
Plug 'christoomey/vim-tmux-navigator'                           " easy tmux navigation
Plug 'vim-airline/vim-airline'                                  " airline themes
Plug 'vim-airline/vim-airline-themes'                           " airline themes
Plug 'w0rp/ale'                                                 " linting and autoformatting

" languages
Plug 'cespare/vim-toml'
Plug 'ledger/vim-ledger'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'

" color schemes
Plug 'tomasr/molokai'                     " Molokai

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
filetype plugin indent on
colorscheme molokai

set number relativenumber                                       " line numbering
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab     " indentation with spaces
set list                                                        " show hidden characters
set colorcolumn=+1                                              " text width rule
set formatoptions+=t                                            " wrap lines on text width
set textwidth=100                                               " default text width
set mouse=a                                                     " mouse support
set nowrap                                                      " do not wrap lines visually

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Language Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c          setlocal tabstop=8 shiftwidth=8 noexpandtab textwidth=80
autocmd FileType cabal      setlocal tabstop=2 shiftwidth=2 expandtab smarttab
autocmd FileType haskell    setlocal tabstop=2 shiftwidth=2 expandtab smarttab textwidth=78 formatprg=stylish-haskell
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab smarttab textwidth=78
autocmd FileType html       setlocal tabstop=2 shiftwidth=2 expandtab smarttab textwidth=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Haskell Highlighting
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Rust - handled by rustfmt, not ale
let g:rustfmt_autosave = 1                                                              " rustfmt on save
let g:rust_clip_command = 'xclip -selection clipboard'                                  " for playpen integration
let g:deoplete#sources#rust#racer_binary = '/home/axelmagn/.cargo/bin/racer'            " autocompleter
let g:deoplete#sources#rust#racer_binary = '/home/axelmagn/Workspace/third_party/rust' " autocompleter

" ALE
let g:ale_linters = {
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\}
let g:ale_fixers = {
\   'html': ['prettier'],
\   'javascript': ['prettier'],
\}
let g:ale_fix_on_save = 1
