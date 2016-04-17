runtime! debian.vim

set nocompatible 

" +----------------------------+
" | Color Settings             |
" +----------------------------+
syntax on

"set background=light
set background=dark

colorscheme solarized
"colorscheme scheakur
"colorscheme pride
"colorscheme buddy
"colorscheme gruvbox

set autoindent  "Copy indent from current line when starting a new line
set showcmd		" Show (partial) command in status line.
set showmatch	" Show matching brackets.
set ignorecase	" Do case insensitive matching
set smartcase	" Do smart case matching
set incsearch	" Incremental search
set mouse=a		" Enable mouse usage (all modes)
set encoding=utf-8 " Set default encoding to UTF-8.
set history=1000 " Sets how many lines of history VIM has to remember
set ruler        " display cursor position
set laststatus=2 " always show status line
set wildignore=*.o,*~,*.pyc " ignore compiled files
set scrolloff=7 " set vertical scroll distance to 7 lines
set wildmenu " turn on the wild menu
set hlsearch " highlight search results
set magic " for regular expressions turn magic on
set mat=2 " how many tenths of a second to blink when matching brackets
" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

set number    " Display line numbers
set tabstop=4 " set Tab-length
set expandtab " expand tabs to spaces
set tabpagemax=100 " Sets how many tabs will be opened

" +----------------------------+
" | Own Functions and Key Maps |
" +----------------------------+

function! ToggleRelativeNumber()
	set invrelativenumber
endfunc

nnoremap <C-n> :call ToRelativeNumber()<CR>
