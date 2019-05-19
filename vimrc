" dotfiles -- vimrc
" author: johannst

set nocompatible
inoremap jj <Esc>

if !exists('&mapleader')
   "let mapleader=";"
   " map <Space> as leader
   let mapleader=" "
endif
nnoremap <leader>ev :edit ~/.vimrc<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>

"{{{ Plugin Management

" to install plugins open vim and run :PluginInstall from within vim OR
" vim +PluginInstall +qall from cmd line

filetype off         " necessary for vundle!!!
set runtimepath+=$VIMHOME/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" editor enhancements
Plugin 'johannst/AsyncCmdProcessor.vim'
Plugin 'maralla/completor.vim'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'terryma/vim-multiple-cursors'

" fuzzy finder
Plugin 'airblade/vim-rooter'
Plugin 'junegunn/fzf.vim'

" coding
Plugin 'majutsushi/tagbar'
Plugin 'w0rp/ale'
Plugin 'johannst/Clever-Tabs'

" sugar
Plugin 'chriskempson/base16-vim'

call vundle#end()

"}}}
"{{{ Plugin Config

let s:gEnabledPlugins = []
function! s:ParseVimrcForEnabledPlugins()
   let l:vimrc = readfile($MYVIMRC)
   let l:i = 0
   while 1
      let l:i = match(l:vimrc, '^Plugin', l:i+1)
      if l:i == -1
         break
      endif
      call add(s:gEnabledPlugins, split(l:vimrc[l:i], "'")[1])
   endwhile
endfunction

function! s:IsPluginEnabled(plugin)
   return index(s:gEnabledPlugins, a:plugin)!=-1
endfunction

call s:ParseVimrcForEnabledPlugins()

if s:IsPluginEnabled('majutsushi/tagbar')
   let g:tagbar_ctags_bin=$MYCTAGS
   if !empty(glob(g:tagbar_ctags_bin))
      augroup aug:TagbarKeymaps
         autocmd!
         autocmd FileType c,cpp nnoremap <buffer> <leader>tb :TagbarToggle<CR>
         autocmd FileType tagbar nnoremap <buffer> <leader>tb :TagbarToggle<CR>
         autocmd FileType tagbar nnoremap <buffer> <S-Left> <NOP>
         autocmd FileType tagbar nnoremap <buffer> <S-Right> <NOP>
         autocmd FileType tagbar nnoremap <buffer> <S-h> <NOP>
         autocmd FileType tagbar nnoremap <buffer> <S-l> <NOP>
      augroup end
   else
      echom "[vimrc]: ctags not detected, please link to " g:tagbar_ctags_bin
   endif
endif

if s:IsPluginEnabled('vim-scripts/YankRing.vim')
   let g:yankring_max_history= 15
   let g:yankring_persist = 1
   let g:yankring_history_dir = $VIMHOME
   let g:yankring_history_file = 'yankring'

   nnoremap <leader>y :YRShow<CR>
   "nnoremap <leader>ys :YRSearch<CR>
endif

if s:IsPluginEnabled('johannst/AsyncCmdProcessor.vim')
   execute "nnoremap <leader>fg :Async find . -type f -exec grep -nHI  {} +"repeat('<Left>', 6)
   execute "vnoremap <leader>fg \"fy:Async find . -type f -exec grep -nHI <C-r>f {} +"repeat('<Left>', 6)
endif

if s:IsPluginEnabled('w0rp/ale')
   let g:ale_sign_column_always = 1
   let g:ale_sign_error = '>>'
   let g:ale_sign_warning = '--'
   let g:ale_set_highlights = 1
   "let g:ale_open_list = 1
   let g:ale_change_sign_column_color = 1
   hi link ALESignColumnWithoutErrors LineNr
   hi link ALESignColumnWithErrors LineNr
endif

if s:IsPluginEnabled('junegunn/fzf.vim')
   nnoremap <leader>ft :BTags<CR>
   nnoremap <leader>fc :Tags<CR>
   nnoremap <leader>ff :Files<CR>
   nnoremap <leader>fp :Files 
   nnoremap <leader>fl :Lines<CR>
   nnoremap <leader>fb :Buffers<CR>
   nnoremap <leader>fs :History/<CR>
   nnoremap <leader>fh :History:<CR>
   let g:fzf_action = { 'ctrl-s': 'split',
                      \ 'ctrl-v': 'vsplit' }

   command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
   nnoremap <leader>rg :Rg 
endif

if s:IsPluginEnabled('chriskempson/base16-vim')
   syntax on
   let base16colorspace=256
else
   colorscheme johannst
endif

"}}}
"{{{ Vim Basic

filetype plugin indent on       " enable loading indent file for filetype
set fileformats=unix,dos,mac    " try recognizing dos, unix, and mac line endings.
set encoding=utf-8              " set default encoding to UTF-8.

set confirm                     " prompt if closing with unsaved changes.
set shortmess=tTa               " use abbreviations in messages and truncate too long strings
set showcmd                     " show command at end of cmd line (like keymaps,..)

set scrolloff=4                 " set vertical scroll distance to 3 lines
set nowrap                      " dont't wrap text

set backspace=indent,eol,start  " backspace behav in insert mode

set noautowrite                 " never write a file unless I request it.
set noautowriteall              " NEVER.
set noautoread                  " don't automatically re-read changed files.

set number                      " display line numbers
set relativenumber              " display relative line numbers

set virtualedit=block

set list                        " show invisible character
set listchars=tab:>-,trail:-,precedes:<,extends:>
augroup aug:HighlightTrailingWhitespace
   autocmd!
   "autocmd BufEnter * 2match Error /\m\(\s\+$\|\([^\t]\)\@<=\t\)/
   autocmd BufEnter * 2match Error /\m\(\s\+$\)/
   autocmd BufLeave * 2match none
augroup end

set clipboard=unnamed           " additionally use (") register as clipboard to (+) register

nnoremap <leader><space> <C-^>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>dw :windo diffthis<CR>
nnoremap <leader>dn :diffoff!<CR>

"}}}
"{{{ Basic Movement

augroup aug:HelpPageKeyMaps
   autocmd!
   autocmd FileType help nnoremap <buffer> <CR> g<C-]>
augroup end

" ctrl-ae jump to line start/end
nnoremap <C-a> 0
nnoremap <C-e> $
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
vnoremap <C-a> 0
vnoremap <C-e> $
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

"}}}
"{{{ Folding

set foldlevel=0
set foldcolumn=1
set foldmethod=marker
set foldmarker={{{,}}}

augroup aug:FileTypeCommentString
   autocmd!
   autocmd FileType vim execute "let b:comment_symbol=\"\\\"\""
   autocmd FileType c,cpp execute "let b:comment_symbol=\"//\""
   autocmd FileType sh,config,make,python,tcl  execute "let b:comment_symbol=\"#\""
   autocmd FileType tex,bib  execute "let b:comment_symbol=\"%\""
augroup end

augroup aug:FoldMarkerKeymaps
   autocmd!
   autocmd FileType * if exists('b:comment_symbol') | execute "nnoremap <buffer> <leader>fm o". b:comment_symbol . "{{{ <Esc>o" . b:comment_symbol. "}}}<Esc><Up>A" | endif
   "autocmd FileType * if exists('b:comment_symbol') | execute "inoremap <buffer> <leader>fm <Esc>o". b:comment_symbol . "{{{ <Esc>o" . b:comment_symbol. "}}}<Esc><Up>A" | endif
   autocmd FileType * if exists('b:comment_symbol') | execute "vnoremap <buffer> <leader>fm VV'<O". b:comment_symbol . "{{{ <Esc>'>o" . b:comment_symbol. "}}}<Esc>'<<Up>A" | endif
augroup end

"}}}
"{{{ Tabwidth

"set expandtab                 " expand tabs to spaces
set tabstop=4                 " number of columns a tab counts
set shiftwidth=4              " number of columns text is indented
set softtabstop=4             " number of columns tab counts in insert mode
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

nnoremap <leader>n :noh<CR>
execute "vnoremap <leader>r \"ry:%s/<C-r>r/<C-r>r/gc" . repeat('<Left>', 3)
execute "vnoremap <leader>rb \"ry:bufdo%s/<C-r>r/<C-r>r/gc" . repeat('<Left>', 3)

"}}}
"{{{ Buffer & Splits

set hidden                    " do not unload abandoned buffers
noremap <leader>q :bd

" navigate between different buffers
nnoremap <S-Left>  :bprevious<CR>
nnoremap <S-Right> :bnext<CR>
nnoremap <S-h>  :bprevious<CR>
nnoremap <S-l>  :bnext<CR>

nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
" move between splits
nnoremap <C-Down>  <C-w>j
nnoremap <C-Up>    <C-w>k
nnoremap <C-Right> <C-w>l
nnoremap <C-Left>  <C-w>h
nnoremap <C-j>     <C-w>j
nnoremap <C-k>     <C-w>k
nnoremap <C-l>     <C-w>l
nnoremap <C-h>     <C-w>h

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

function! DynamicStatuslineHighlighting()
   if (mode() ==# 'n' || mode() ==# 'no' || mode() ==# 'c')
      execute 'hi! StatusLine   ctermfg=NONE   ctermbg=5 cterm=NONE'
   elseif (mode() ==# 'i')
      execute 'hi! StatusLine   ctermfg=18   ctermbg=2  cterm=NONE'
   elseif (mode() ==# 'v' || mode() ==# 'V' || g:ModeMap[mode()] ==# 'V-Block')
      execute 'hi! StatusLine   ctermfg=18   ctermbg=4  cterm=NONE'
   else
      execute 'hi! StatusLine   ctermfg=18   ctermbg=16  cterm=NONE'
   endif
   return ''
endfunction

let &statusline=''
let &statusline.='%{DynamicStatuslineHighlighting()}'
let &statusline.='[%{g:ModeMap[mode()]}]'
let &statusline.=' %t'        " file name
let &statusline.=' {%M%R%H}'  " modified/read-only/help-page
let &statusline.='%{&diff==1?" [diff]":""}'
let &statusline.=' [%{&ft}]'  "filetype

let &statusline.='%='             " seperator between left and right alignment
if v:version >= 800 && s:IsPluginEnabled('johannst/AsyncCmdProcessor.vim')
   let &statusline.=' [A:%{GetAsyncJobStatus()}]'
endif
let &statusline.=' [%b:0x%B]'     " dec:hex ascii value of char under cursor
let &statusline.=' [%l/%L -- %c]' " current line/num of lines -- current columen
let &statusline.=' (%p%%)'        " current line in percent

"}}}
"{{{ Indentation

set autoindent                " copy indent from current line when starting a new line
set smartindent               " use smart indent if there is no indent file

"}}}
"{{{ Wildmenu

" Vim command completion settings
set wildmenu                  " turn on the wild menu
set wildmode=list:longest     " <Tab> print list of all matches and complete till longest common string
set wildignore+=*.o,*.obj,.git,*.pyc,*~ " Ignore these files when completing

"}}}
"{{{ Filetype specifics

augroup aug:VimLangStyle
   autocmd!
   autocmd FileType vim setlocal formatoptions-=cro   " disable auto-comment
augroup end

augroup aug:CLangStyle
   autocmd!
   "autocmd FileType c,cpp setlocal cinoptions=:1,=2,g1,h2  " switch-case/class-lable indentation
   autocmd FileType c,cpp setlocal formatoptions-=cro      " disable auto-comment
augroup end

"}}}

"% vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1:et

