""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" VIM Configuration
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author:
"   Axel Magnuson
"
" Sections:
"   - Vundle
"   - Plugins
"   - General
"   - File Types
"   - VIM user interface
"   - Colors and Fonts
"   - Files and backups
"   - Text, tab and indent related
"   - Visual mode related
"   - Moving around, tabs and buffers
"   - Status line
"   - Editing mappings
"   - vimgrep searching and cope displaying
"   - Spell checking
"   - Misc
"   - Helper functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable Vi compatibility.
" Required for vundle (and generally a good idea)
set nocompatible
filetype off        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" BEGIN Vundle managed plugins
call vundle#begin()

" let vundle manage vundle, required
Plugin 'VundleVim/Vundle.vim'

" Behavior Plugins
Plugin 'Xuyuanp/nerdtree-git-plugin'    " show git status in file tree
Plugin 'airblade/vim-gitgutter'         " Git changes show up in gutter
Plugin 'bling/vim-airline'              " tabline
Plugin 'christoomey/vim-tmux-navigator' " easy tmux navigation
Plugin 'ervandew/supertab'              " tab completion
Plugin 'kien/ctrlp.vim'                 " Fuzzy finder (<C-p>)
Plugin 'kien/rainbow_parentheses.vim'   " pretty nested parens
Plugin 'majutsushi/tagbar'              " class outline viewer
Plugin 'scrooloose/nerdcommenter'       " commenting utility
Plugin 'scrooloose/nerdtree'            " file tree (<leader>n)
Plugin 'scrooloose/syntastic'           " syntax checking
Plugin 'tpope/vim-fugitive'             " Git wrapper
Plugin 'tpope/vim-surround'             " quoting/parenthesizing utility
Plugin 'shougo/vimproc.vim'             " async execution

" Colorscheme Plugins
Plugin 'altercation/vim-colors-solarized'   " Solarized
Plugin 'tomasr/molokai'                     " Molokai
Plugin 'vim-airline/vim-airline-themes'     " airline themes

" Language Plugins
Plugin 'cespare/vim-toml'                   " TOML
Plugin 'derekwyatt/vim-scala'               " Scala
Plugin 'dylon/vim-antlr'                    " Antlr
Plugin 'elixir-lang/vim-elixir'             " Elixir
Plugin 'fatih/vim-go'                       " Go
Plugin 'guns/vim-clojure-highlight'         " Clojure Advanced Highlighting
Plugin 'guns/vim-clojure-static'            " Clojure
Plugin 'lervag/vimtex'                      " latex
Plugin 'rust-lang/rust.vim'                 " Rust
Plugin 'tpope/vim-fireplace'                " Clojure REPL
Plugin 'tpope/vim-markdown'                 " Markdown
Plugin 'mustache/vim-mustache-handlebars'   " Mustache
Plugin 'leafgarland/typescript-vim'         " Typescript Syntax
Plugin 'Quramy/tsuquyomi'                   " Typescript omnicomplete
Plugin 'pangloss/vim-javascript'            " javascript syntax
Plugin 'mxw/vim-jsx'                        " JSX javascript
Plugin 'tpope/vim-haml'                     " HAML / SASS / SCSS
Plugin 'gorodinskiy/vim-coloresque'         " CSS color preview
Plugin 'neo4j-contrib/cypher-vim-syntax'    " Neo4j Cypther




" END vundle managed plugins
call vundle#end()           " required


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These high-level settings are very important but don't
" really fit anywhere else.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set how many lines vim should remember
set history=700

filetype on         " Enable filetype detection
filetype plugin on  " Load filetype plugin files
filetype indent on  " Load filetype indent files

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving with ,w
nmap <leader>w :w!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" NERD Tree
""""""""""""""""""""""""""""""""""""""""
" open NERD Tree with <C-n>
map <leader>n :NERDTreeToggle<CR>
" close vim if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1
                     \ && exists("b:NERDTree")
                     \ && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""
" Syntastic
""""""""""""""""""""""""""""""""""""""""
" add syntastic info to statusline
" (see statusline section)

" populate the location-list with the errors found by the checkers
let g:syntastic_always_populate_loc_list = 0
" automatically open/close error window when errors are detected/empty
let g:syntastic_auto_loc_list = 0
" run syntax checks when buffers are first loaded
let g:syntastic_check_on_open = 1
" don't run syntax checks when quitting (pointless)
let g:syntastic_check_on_wq = 0
" use flake8 as python linter
let g:syntastic_python_checkers = ['flake8']
" disable latex checkers
let g:syntastic_latex_checkers = []
let g:syntastic_tex_checkers = []
" set rst checker to sphinx
let g:syntastic_rst_checkers = ['sphinx']
" set js linter to eslint
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['jsxhint']
" turn of tex window box
let g:syntastic_tex_chktex_showmsgs = 0

""""""""""""""""""""""""""""""""""""""""
" Solarized
""""""""""""""""""""""""""""""""""""""""
" by default, use ANSII colors.  Uncomment this in unconfigured terminals
" let g:solarized_termcolors = 256  " indicate that 256 colors are available

""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1


""""""""""""""""""""""""""""""""""""""""
" Tagline
""""""""""""""""""""""""""""""""""""""""
map  <leader>t :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""""""""
" LaTeX
""""""""""""""""""""""""""""""""""""""""
let g:Tex_IgnoredWarnings =
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n".
	\'Wrong length of dash may have been used.'."\n"
let g:Tex_IgnoreLevel = 9
let g:Tex_GotoError = 0

""""""""""""""""""""""""""""""""""""""""
" Typescript
""""""""""""""""""""""""""""""""""""""""
let g:syntastic_typescript_tsc_fname = ''

""""""""""""""""""""""""""""""""""""""""
" Typescript
""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType c           setlocal noexpandtab shiftwidth=8 tabstop=8
                        \ softtabstop=8 textwidth=79
au FileType cpp         setlocal noexpandtab shiftwidth=8 tabstop=8
                        \ softtabstop=8 textwidth=120
au FileType python      setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
                        \ textwidth=79 foldmethod=indent nosmartindent
                        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au FileType coffee      setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
                        \ smartindent
                        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au FileType htmldjango  setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
au FileType html        setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
au FileType jade        setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
au FileType yaml        setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2
au FileType go          setlocal noexpandtab
au FileType snippets    setlocal noexpandtab
au FileType make        setlocal noexpandtab shiftwidth=8 tabstop=8
                        \ softtabstop=8
au FileType javascript  setlocal textwidth=80 expandtab shiftwidth=2 tabstop=8 softtabstop=2
au FileType gitcommit setlocal textwidth=72

au BufRead,BufNewFile *.tex set filetype=tex

au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on mouse compatibility.  Look at us being all modern
set mouse=a

" Display trailing whitespace
set list
set listchars=tab:→·,trail:·
highlight TrailS ctermbg=red ctermfg=white guibg=#592929
match TrailS /\s\+$/

" default fold method
set foldmethod=syntax

" Cursor line and column
set cursorline

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" colorscheme desert
set background=dark
colorscheme molokai
" colorscheme solarized

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" set 256color regardless
set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" vertical rule for text width
set colorcolumn=+1
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

" line numbers preferred
set number              " show line number of current line
set relativenumber      " show relative line numbers on other lines

" Linebreak on textwidth
set linebreak
set textwidth=79

set ai "Auto indent
set si "Smart indent
set nowrap " (DON'T!) Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ Col:\ %c
" add syntastic status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


