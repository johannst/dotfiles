" dotfiles -- vimrc
" author: johannst

set nocompatible     
inoremap jj <Esc>

let mapleader=";"
nnoremap <leader>ev :edit ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>

"{{{ Plugin Management 

" to install plugins open vim and run :PluginInstall from within vim OR
" vim +PluginInstall +qall from cmd line

filetype off         " necessary for vundle!!!
set runtimepath+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

let s:bufexplorer_enable="-"
Plugin 'jlanzarotta/bufexplorer'

let s:buftabline_enable="-"
Plugin 'ap/vim-buftabline'

"let s:airline_enable="-"
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'

let s:tagbar_enable="-"
Plugin 'majutsushi/tagbar'

let s:ctrlp_enable="-"
Plugin 'kien/ctrlp.vim'

"let s:omnicppcomplete_enable="-"
"Plugin 'vim-scripts/OmniCppComplete'

call vundle#end()         

"}}}
"{{{ Plugin Config 

if exists('s:bufexplorer_enable')
   nnoremap <leader>be :call BufExplorer()<CR>
endif

if exists('s:airline_enable')
   let g:airline#extensions#tabline#enabled = 1
   let g:airline#extensions#tabline#fnamemod = ':t'
   let g:airline_powerline_fonts = 1
   if !exists('g:airline_symbols')
      let g:airline_symbols = {}
   endif
endif

if exists('s:tagbar_enable')
   let g:tagbar_ctags_bin='~/.vim/bin/ctags'
   if !empty(glob(g:tagbar_ctags_bin))
      augroup aug:TagbarKeymaps
         autocmd!
         autocmd FileType c,cpp nnoremap <buffer> <leader>tb :TagbarToggle<CR>
      augroup end
   else
      echom "[vimrc]: ctags not detected, please link to " g:tagbar_ctags_bin
   endif
endif

if exists('s:ctrlp_enable')
   let g:ctrlp_buftag_ctags_bin='~/.vim/bin/ctags'
   let g:ctrlp_extensions = ['buffertag', 'line', 'changes', 'mixed']
endif

if exists('s:buftabline_enable')
   let g:buftabline_indicators = 1
endif

if exists('s:omnicppcomplete_enable')
   set tags+=~/.vim/tags/cpp_tags
   let OmniCpp_NamespaceSearch = 1
   let OmniCpp_GlobalScopeSearch = 1
   let OmniCpp_ShowAccess = 1
   let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
   let OmniCpp_MayCompleteDot = 1 " autocomplete after .
   let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
   let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
   let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
   " automatically open and close the popup menu / preview window
   autocmd! CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
   set completeopt=menuone,menu,longest,preview
endif

"}}}
"{{{ Vim Basic

syntax on
"set background=dark
colorscheme johannst

filetype plugin indent on       " enable loading indent file for filetype
set fileformats=unix,dos,mac    " try recognizing dos, unix, and mac line endings.
set encoding=utf-8              " set default encoding to UTF-8.

set confirm                     " prompt if closing with unsaved changes.
set shortmess=tTa               " use abbreviations in messages and truncate too long strings
set showcmd                     " show command at end of cmd line (like keymaps,..)

set scrolloff=3                 " set vertical scroll distance to 3 lines
set nowrap                      " dont't wrap text

set backspace=indent,eol,start  " backspace behav in insert mode

set noautowrite                 " never write a file unless I request it.
set noautowriteall              " NEVER.
set noautoread                  " don't automatically re-read changed files.

set number                      " display line numbers
set relativenumber              " display relative line numbers

set cursorline                  " cursor line highlighting
set cursorcolumn                " cursor column highlighting 

"set list                        " show invisible character
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>

"}}}
"{{{ Basic Movement

" ctrl-ae jump to line start/end 
nnoremap <C-a> 0
nnoremap <C-e> $
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
vnoremap <C-a> 0
vnoremap <C-e> $
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"}}}
"{{{ Folding 

set foldmethod=marker     

augroup aug:FileTypeCommentString
   autocmd!
   autocmd FileType vim execute "let b:comment_symbol=\"\\\"\""
   autocmd FileType c,cpp execute "let b:comment_symbol=\"//\""
   autocmd FileType sh,config,make,python  execute "let b:comment_symbol=\"#\""
augroup end

augroup aug:FoldMarkerKeymaps
   autocmd!
   autocmd FileType * if exists('b:comment_symbol') | execute "nnoremap <buffer> <leader>fm o". b:comment_symbol . "{{{ <Esc>o" . b:comment_symbol. "}}}<Esc><Up>A" | endif
   autocmd FileType * if exists('b:comment_symbol') | execute "inoremap <buffer> <leader>fm <Esc>o". b:comment_symbol . "{{{ <Esc>o" . b:comment_symbol. "}}}<Esc><Up>A" | endif
   autocmd FileType * if exists('b:comment_symbol') | execute "vnoremap <buffer> <leader>fm VV'<O". b:comment_symbol . "{{{ <Esc>'>o" . b:comment_symbol. "}}}<Esc>'<<Up>A" | endif
augroup end

"}}}
"{{{ Tabwidth 

set expandtab                 " expand tabs to spaces
set tabstop=8                 " number of columns a tab counts
set shiftwidth=3              " number of columns text is indented 
set softtabstop=3             " number of columns tab counts in insert mode
set shiftround                " rounds indent to a multiple of shiftwidth

"}}}
"{{{ Search & Replace

set ignorecase                " case insensitive matching
set incsearch                 " already start searching while typing pattern
set hlsearch                  " highlight search results
set smartcase                 " overwrite ignorecase if pattern contains capital letters
set showmatch                 " show matching brackets.
set matchtime=5               " how many tenths of a second to blink when matching brackets
set matchpairs+=<:>           " show matching <> as well

vnoremap <leader>r "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>

"}}}
"{{{ Buffer & Splits 

set hidden                    " do not unload abandoned buffers
noremap <leader>q :bd

" navigate between different buffers 
nnoremap <S-Left>  :bprevious<CR>
nnoremap <S-Right> :bnext<CR>
nnoremap <S-h>  :bprevious<CR>
nnoremap <S-l>  :bnext<CR>

" move between splits
nnoremap <C-Down>  <C-w>j
nnoremap <C-Up>    <C-w>k
nnoremap <C-Right> <C-w>l
nnoremap <C-Left>  <C-w>h
nnoremap <C-j>     <C-w>j
nnoremap <C-k>     <C-w>k
nnoremap <C-l>     <C-w>l
nnoremap <C-h>     <C-w>h

" resize splits
"(deprecated) map <C-j>     <C-w>5-
"(deprecated) map <C-k>     <C-w>5+
"(deprecated) map <C-l>     <C-w>5<
"(deprecated) map <C-h>     <C-w>5>

"}}}
"{{{ Statusline 

set laststatus=2              " always show status line

let g:ModeMap={
         \ 'n'  : 'Normal',
         \ 'no' : 'N-Operator Pending',
         \ 'v'  : 'Visual',
         \ 'V'  : 'V-Line',
         \ '' : 'V-Block',
         \ 's'  : 'Select',
         \ 'S'  : 'S-Line',
         \ '' : 'S-Block',
         \ 'i'  : 'Insert',
         \ 'R'  : 'Replace',
         \ 'Rv' : 'V-Replace',
         \ 'c'  : 'Command',
         \ 'cv' : 'Vim Ex',
         \ 'ce' : 'Ex',
         \ 'r'  : 'Prompt',
         \ 'rm' : 'More',
         \ 'r?' : 'Confirm',
         \ '!'  : 'Shell',
         \}

" TODO: find nice colors for different modes
function! DynamicStatuslineHighlighting()
   if (mode() ==# 'n' || mode() ==# 'no' || mode() ==# 'c')
      execute 'hi! StatusLine   ctermfg=NONE   ctermbg=125 cterm=NONE'
   elseif (mode() ==# 'i')
      execute 'hi! StatusLine   ctermfg=NONE   ctermbg=38  cterm=NONE'
   elseif (mode() ==# 'v' || mode() ==# 'V' || g:ModeMap[mode()] ==# 'V-Block')
      execute 'hi! StatusLine   ctermfg=NONE   ctermbg=33  cterm=NONE'
   else
      execute 'hi! StatusLine   ctermfg=NONE   ctermbg=226  cterm=NONE'
   endif
   return ''
endfunction 

let &statusline=''        
let &statusline.='%{DynamicStatuslineHighlighting()}'
let &statusline.='[%{g:ModeMap[mode()]}]'
let &statusline.=' '      
let &statusline.='%t'        " file name
let &statusline.=' '      
let &statusline.='{%M%R%H}'  " modified/read-only/help-page
let &statusline.=' '      
let &statusline.='[%{&ft}'                          "filetype
"let &statusline.='%{&ft!=""?&ft.",":""}'           "filetype
"let &statusline.='%{&fenc!=""?&fenc.",":&enc.","}' " file encoding
"let &statusline.='%{&ff}'                          " file format
let &statusline.=']'             

let &statusline.='%='     " seperator between left and right alignment
let &statusline.=' '      
let &statusline.='[%b'    " decimal ascii value of char under cursor
let &statusline.=':'      
let &statusline.='0x%B]'  " hexadecimal ascii value of char under cursor
let &statusline.=' '      
let &statusline.='[%l'    " current line
let &statusline.='/'      
let &statusline.='%L'     " num of lines
let &statusline.=' -- '      
let &statusline.='%c]'    " current column
let &statusline.=' '      
let &statusline.='(%p%%)' " current line in percent

"}}}
"{{{ Indentation 

nnoremap <leader>ri mzgg=G`z
set autoindent                " copy indent from current line when starting a new line
set smartindent               " use smart indent if there is no indent file

augroup aug:VimLangStyle
   autocmd!
   autocmd FileType vim setlocal formatoptions-=cro   " disable auto-comment
augroup end

augroup aug:CLangStyle
   autocmd!
   autocmd FileType c,cpp setlocal cinoptions=:1,=2,g1,h2  " switch-case/class-lable indentation
   autocmd FileType c,cpp setlocal formatoptions-=cro      " disable auto-comment
augroup end

"}}}
"{{{ Wildmenu 

" Vim command completion settings
set wildmenu                  " turn on the wild menu
set wildmode=longest:full     " <Tab> cycles between all matching choices.
set wildignore+=*.o,*.obj,.git,*.pyc,*~ " Ignore these files when completing

"}}}
"{{{ Save & Restore 

augroup aug:AutoSaveResore
   autocmd!
   "autocmd VimEnter * silent! source .vim_last_session
   "autocmd QuitPre * mksession! .vim_last_session
augroup end

"}}}
"{{{ QuickFix 

augroup aug:QuickFixConfig
   autocmd!
   autocmd QuickFixCmdPost [^l]* nested botright cwindow
   autocmd QuickFixCmdPost    l* nested botright lwindow
augroup end

"}}}
"{{{ SCons Integration 

function! TriggerSCons(...)
   let l:base_cmd = 'scons'
   "let base_cmd = "scons -u"
   let l:arg_str = ''
   for k in a:000
      let l:arg_str = l:arg_str . ' ' . k
   endfor
   let &makeprg = l:base_cmd . l:arg_str
   make
endfunction
" use like :SCons -j20 ...
command! -nargs=* SCons call TriggerSCons(<f-args>)

"}}}
"{{{ Tmux Specific 

"" tmux will send xterm-style keys when its xterm-keys option is on
"if &term =~ '^screen'
"   execute "set <xUp>=\e[1;*A"
"   execute "set <xDown>=\e[1;*B"
"   execute "set <xRight>=\e[1;*C"
"   execute "set <xLeft>=\e[1;*D"
"endif

"}}}
