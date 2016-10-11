" dotfiles -- .vimrc
" author: johannst

set nocompatible     " make vim less vi 

"{{{ Vundle

   " to install plugins open vim and run :PluginInstall from within vim OR
   " vim +PluginInstall +qall from cmd line

   filetype off         " necessary for vundle!!!
   set rtp+=~/.vim/bundle/Vundle.vim

   call vundle#begin()
   Plugin 'VundleVim/Vundle.vim'
   Plugin 'jlanzarotta/bufexplorer'
   Plugin 'vim-airline/vim-airline'
   Plugin 'vim-airline/vim-airline-themes'
   Plugin 'majutsushi/tagbar'
   Plugin 'kien/ctrlp.vim'
   " c++ modifief headers: http://www.vim.org/scripts/script.php?script_id=2358
   "Plugin 'vim-scripts/OmniCppComplete'
   call vundle#end()         

"}}}
"{{{ Plugin Config

   " powerline
   let g:airline#extensions#tabline#enabled = 1
   let g:airline#extensions#tabline#fnamemod = ':t'
   let g:airline_powerline_fonts = 1
   if !exists('g:airline_symbols')
        let g:airline_symbols = {}
   endif

   " tagbar
   let g:tagbar_ctags_bin='~/.vim/bin/ctags'

   " omni complete
   " add tags
   " set tags+=~/.vim/tags/cpp_tags
   "let OmniCpp_NamespaceSearch = 1
   "let OmniCpp_GlobalScopeSearch = 1
   "let OmniCpp_ShowAccess = 1
   "let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
   "let OmniCpp_MayCompleteDot = 1 " autocomplete after .
   "let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
   "let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
   "let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
   "" automatically open and close the popup menu / preview window
   "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
   "set completeopt=menuone,menu,longest,preview

"}}}

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
set ttimeoutlen=100           " time in ms for key code delay, NEVER USE 0 again!!! if random numbers/letters occur, maybe change this value

filetype plugin indent on     " enable loading indent file for filetype
set ffs=unix,dos,mac          " try recognizing dos, unix, and mac line endings.
set encoding=utf-8            " set default encoding to UTF-8.

" Basic settings
set title                     " show title in console title bar
set confirm                   " prompt if closing with unsaved changes.
set laststatus=2              " always show status line
set shortmess+=a              " Use [+]/[RO]/[w] for modified/readonly/written.
set showcmd                   " show command in status line.
set mouse=a                   " enable mouse usage (all modes)
set history=1000              " sets how many lines of history VIM has to remember
set tabpagemax=100            " sets how many tabs will be opened
set scrolloff=3               " set vertical scroll distance to 7 lines
set backspace=2               " had some issues with BS on empty line didn't deleted line
set noautowrite               " never write a file unless I request it.
set noautowriteall            " NEVER.
set noautoread                " don't automatically re-read changed files.

" Line/Column settings
set number                    " Display line numbers
set relativenumber            " Display relative line numbers
set ruler                     " display cursor position
set cursorline                " cursor line highlighting
set cursorcolumn              " cursor column highlighting 

" buffer settings
set hidden                    " do not unload abandoned buffers

" Tab settings 
set expandtab                 " expand tabs to spaces
set tabstop=8                 " number of columns a tab counts
set shiftwidth=3              " number of columns text is indented 
set softtabstop=3             " number of columns tab counts in insert mode
set shiftround                " rounds indent to a multiple of shiftwidth
"set smarttab                  " Handle tabs more intelligently 

" Fold settings
set foldmethod=marker         " set fold method

" Indentation settings
set autoindent                " copy indent from current line when starting a new line
set smartindent               " use smart indent if there is no indent file
autocmd BufRead,BufNewFile *.h,*.hh,*.hpp,*.c,*.cc,*.cpp set cinoptions=:1,=2,g1,h2  " switch-case/class-lable indentation
autocmd BufRead,BufNewFile * setlocal formatoptions-=cro   " disable auto-comment

" Invisible character settings
"set list                     " show invisible character
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>

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

"{{{ Keymaps

   " set leader key
   "execute "set <M-s>=\es"
   let mapleader=";"

   " re-source .vimrc
   map <leader>v :source ~/.vimrc<CR>

   "remap esc button
   imap jj <Esc>

   " quit buffer
   noremap <leader>q :bd

   " re-adjust indentation
   map <leader>f mzgg=G`z

   " navigate between different splits 
   map <C-Down>  <C-w>j
   map <C-Up>    <C-w>k
   map <C-Right> <C-w>l
   map <C-Left>  <C-w>h
   map <C-j>     <C-w>j
   map <C-k>     <C-w>k
   map <C-l>     <C-w>l
   map <C-h>     <C-w>h

   " resize splits
   "map <C-j>     <C-w>5-
   "map <C-k>     <C-w>5+
   "map <C-l>     <C-w>5<
   "map <C-h>     <C-w>5>

   " navigate between different buffers 
   nnoremap <S-Left>  :bprevious<CR>
   nnoremap <S-Right> :bnext<CR>
   nnoremap <S-h>  :bprevious<CR>
   nnoremap <S-l>  :bnext<CR>

   " ctrl-ae jump to line start/end 
   nnoremap <C-a> 0
   nnoremap <C-e> $
   inoremap <C-a> <C-o>0
   inoremap <C-e> <C-o>$
   vnoremap <C-a> 0
   vnoremap <C-e> $
   cnoremap <C-a> <Home>
   cnoremap <C-e> <End>

   " Shortcut to toggle relative numbering mode
   nnoremap <C-n> :call ToggleRelativeNumber()<CR>

   " add a marker fold snippet (for C/C++)
   nnoremap <C-f> o//{{{ <Esc>o//}}}<Esc><Up>A
   imap <C-f> <ESC><C-f>
   " only works with v-block (not v-line)
   vnoremap <C-f> VV'<O//{{{<Esc>'>o//}}}<Esc>'<<ESC><Up>A 

   " substitute selection
   vnoremap <C-r> "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>

   " yank/paste into/from register
   vnoremap <C-c> "ay
   inoremap <C-v> <C-r>a
   cnoremap <C-v> <C-r>a

   " +-----------------+
   " | Plugin specific |
   " +-----------------+
   " Open BufferExplorer
   nnoremap <C-b> :call BufExplorer()<CR>

   " Toggle Tagbar 
   nnoremap <leader>t :TagbarToggle<CR>

   " build tags of your own project with Ctrl-F12
   map <C-t> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q --language-force=C++ .<CR>

"}}}
"{{{ Global Highlighting

   " hi clear CursorLine
   " augroup CLClear
   "     autocmd! ColorScheme * hi clear CursorLine
   " augroup END

   "hi LineNr ctermfg=208

   " Highlight color of current line 
   hi CursorLineNR cterm=bold ctermfg=255 ctermbg=208
   "hi CursorLineNR cterm=bold ctermfg=226 
   augroup CLNRSet
      autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermfg=255 ctermbg=208
      "autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermfg=226
   augroup END

   " Highlight status line
   hi StatusLine ctermbg=38 ctermfg=0 cterm=NONE term=NONE gui=NONE
   "hi StatusLineNC ctermbg=81 ctermfg=0

   " matching brackets
   "hi MatchParen cterm=underline ctermbg=141 ctermfg=yellow
   hi MatchParen cterm=underline ctermbg=89 ctermfg=208
   "hi MatchParen cterm=underline ctermbg=DarkMagenta ctermfg=12

"}}}
"{{{ Functions
   " Split Window and scroll down
   function! SplitScroll()
       :wincmd v
       :wincmd w
       execute "normal! \<C-d>"
       :set scrollbind
       :wincmd w
       :set scrollbind
   endfunc

   " toggle relative line number mode
   function! ToggleRelativeNumber()           
       if(&relativenumber == 1)
           set norelativenumber
       else
           set relativenumber
       endif
   endfunc  
"}}}

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
