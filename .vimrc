" dotfiles -- .vimrc
" author: johannst

set nocompatible     " make Vim less Vi 

source ~/.vim/vimrc_files/vundle.vim
source ~/.vim/vimrc_files/plugin_config.vim

" +----------------------------+
" | Color Settings             |
" +----------------------------+
syntax on
set background=dark
colorscheme buddy

" +----------------------------+
" | Basic Settings             |
" +----------------------------+
set timeoutlen=1000           " time in ms until keymap interpreted
set ttimeoutlen=100           " time in ms for key code delay, NEVER USE 0 again!!!

filetype plugin indent on     " enable loading indent file for filetype
set ffs=unix,dos,mac          " Try recognizing dos, unix, and mac line endings.

set number                    " Display line numbers
set relativenumber            " Display relative line numbers
set title                     " show title in console title bar
set cursorline                " cursor line highlighting
set cursorcolumn              " cursor column highlighting 
set confirm                   " Y-N-C prompt if closing with unsaved changes.
set ruler                     " display cursor position
set laststatus=2              " always show status line
set shortmess+=a              " Use [+]/[RO]/[w] for modified/readonly/written.
set showcmd                   " Show (partial) command in status line.

set mouse=a                   " Enable mouse usage (all modes)
set encoding=utf-8            " Set default encoding to UTF-8.
set history=1000              " Sets how many lines of history VIM has to remember
set tabpagemax=100            " Sets how many tabs will be opened
set scrolloff=3               " set vertical scroll distance to 7 lines

" Tab/Indentation settings
set expandtab                 " expand tabs to spaces
set tabstop=8                 " number of columns a tab counts
set shiftwidth=3              " number of columns text is indented 
set softtabstop=3             " number of columns tab counts in insert mode
set shiftround                " rounds indent to a multiple of shiftwidth
"set smarttab                  " Handle tabs more intelligently 
set autoindent                " Copy indent from current line when starting a new line
set smartindent               " use smart indent if there is no indent file

"set list                     " show invisible character
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>

set backspace=2
autocmd BufRead,BufNewFile *.h,*.hh,*.hpp,*.c,*.cc,*.cpp set cinoptions=:1,=2,g1,h2  " switch-case/class-lable indentation
"autocmd BufRead,BufNewFile *.h,*.hh,*.hpp,*.c,*.cc,*.cpp setlocal formatoptions=ql   " disable auto-comment
autocmd BufRead,BufNewFile * setlocal formatoptions-=cro   " disable auto-comment

set foldmethod=marker         " set fold method

set hidden                    " do not unload abandoned buffers
set nowrap                    " don't wrap text
set noautowrite               " Never write a file unless I request it.
set noautowriteall            " NEVER.
set noautoread                " Don't automatically re-read changed files.

" Search settings
set ignorecase                " case insensitive matching
set incsearch                 " incremental search
set hlsearch                  " highlight search results
set smartcase                 " overwrite ignorecase if pattern contains capital letters
set showmatch                 " show matching brackets.
set matchtime=2               " how many tenths of a second to blink when matching brackets
set matchpairs+=<:>           " show matching <> as well
set magic                     " for regular expressions turn magic on

" Vim command completion settings
set wildmenu                  " turn on the wild menu
set wildmode=longest:full     " <Tab> cycles between all matching choices.
set wildignore+=*.o,*.obj,.git,*.pyc,*~ " Ignore these files when completing

" No annoying sound on errors
set noerrorbells
set novisualbell

" automatically open Quickfix
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" +----------------------------+
" | Source Extrenal Files      |
" +----------------------------+
source ~/.vim/vimrc_files/colors.vim
source ~/.vim/vimrc_files/keymaps.vim
source ~/.vim/vimrc_files/highlights.vim
source ~/.vim/vimrc_files/functions.vim

" +----------------------------+
" | Tmux specific settings     |
" +----------------------------+
" tmux will send xterm-style keys when its xterm-keys option is on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
