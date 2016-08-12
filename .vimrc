" dotfiles -- .vimrc
" author: johannst

set nocompatible     " make Vim less Vi 






source ~/.vim/vimrc_files/vundle.vim
source ~/.vim/vimrc_files/plugin_config.vim


" +----------------------------+
" | Color Settings             |
" +----------------------------+
syntax on

" default colorscheme
set background=dark
colorscheme buddy


" +----------------------------+
" | Basic Settings             |
" +----------------------------+
set timeoutlen=1234           " time in ms until keymap interpreted
set ttimeoutlen=1             " time in ms for key code delay, NEVER USE 0 again!!!

filetype plugin indent on     " enable loading indent file for filetype
set ffs=unix,dos,mac          " Try recognizing dos, unix, and mac line endings.

set number                    " Display line numbers
set relativenumber            " Display relative line numbers
set title                     " show title in console title bar
set cursorline                " cursor line highlighting
set cursorcolumn              " cursor column highlighting 
set confirm                   " Y-N-C prompt if closing with unsaved changes.

set mouse=a		              " Enable mouse usage (all modes)
set encoding=utf-8            " Set default encoding to UTF-8.
set history=1000              " Sets how many lines of history VIM has to remember
set tabpagemax=100            " Sets how many tabs will be opened
set scrolloff=2               " set vertical scroll distance to 7 lines
set tabstop=4                 " set Tab-length
set expandtab                 " expand tabs to spaces
set shiftwidth=4              " but an indent level is 2 spaces wide.
set softtabstop=4             " <BS> over an autoindent deletes both spaces.
set shiftround                " rounds indent to a multiple of shiftwidth
set backspace=2
autocmd BufNewFile,BufRead * setlocal formatoptions=ql   " disable auto-comment

set foldmethod=marker         " set fold method

set hidden                    " do not unload abandoned buffers
set nowrap                    " don't wrap text
set noautowrite               " Never write a file unless I request it.
set noautowriteall            " NEVER.
set noautoread                " Don't automatically re-read changed files.
set shortmess+=a              " Use [+]/[RO]/[w] for modified/readonly/written.

set smarttab                  " Handle tabs more intelligently 
set smartcase	              " Do smart case matching
set autoindent                " Copy indent from current line when starting a new line
set smartindent               " use smart indent if there is no indent file
set showmatch	              " Show matching brackets.
set mat=2                     " how many tenths of a second to blink when matching brackets
set matchpairs+=<:>           " show matching <> as well
set hlsearch                  " highlight search results
set ignorecase	              " Do case insensitive matching
set incsearch	              " Incremental search
set magic                     " for regular expressions turn magic on


set ruler        " display cursor position
set laststatus=2 " always show status line
set showcmd		 " Show (partial) command in status line.


set wildmenu                  " turn on the wild menu
set wildmode=full             " <Tab> cycles between all matching choices.
" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc,*~

" No annoying sound on errors
set noerrorbells
set novisualbell

" automatically open Quickfix
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
nnoremap <leader>m :silent make!\|redraw!\|cc<CR>
nnoremap <leader>g :silent grep! -R \|redraw!\|cc

" +----------------------------+
" | Source Extrenal Files      |
" +----------------------------+
source ~/.vim/vimrc_files/colors.vim
source ~/.vim/vimrc_files/keymaps.vim
source ~/.vim/vimrc_files/highlights.vim
source ~/.vim/vimrc_files/functions.vim
