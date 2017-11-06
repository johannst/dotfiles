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

"let $VIMHOME='~/.vim'

"{{{ Plugin Management 

" to install plugins open vim and run :PluginInstall from within vim OR
" vim +PluginInstall +qall from cmd line

filetype off         " necessary for vundle!!!
set runtimepath+=$VIMHOME/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'jlanzarotta/bufexplorer'
Plugin 'ap/vim-buftabline'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'vim-scripts/OmniCppComplete'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'johannst/Clever-Tabs'

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
call s:ParseVimrcForEnabledPlugins()

if index(s:gEnabledPlugins, 'jlanzarotta/bufexplorer')!=-1
   nnoremap <leader>be :call ToggleBufExplorer()<CR>
   let g:bufExplorerDisableDefaultKeyMapping=1
endif

if index(s:gEnabledPlugins, 'vim-airline/vim-airline')!=-1
   let g:airline#extensions#tabline#enabled = 1
   let g:airline#extensions#tabline#fnamemod = ':t'
   let g:airline_powerline_fonts = 1
   if !exists('g:airline_symbols')
      let g:airline_symbols = {}
   endif
endif

if index(s:gEnabledPlugins, 'majutsushi/tagbar')!=-1
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

if index(s:gEnabledPlugins, 'ctrlpvim/ctrlp.vim')!=-1
   let g:ctrlp_buftag_ctags_bin=$VIMHOME . '/bin/ctags'
   let g:ctrlp_extensions = ['buffertag']
   let g:ctrlp_working_path_mode = 'a'
   let g:ctrlp_use_caching = 1
   let g:ctrlp_clear_cache_on_exit = 1
   let g:ctrlp_cache_dir = $VIMHOME . '/cache/ctrlp'

   nnoremap <leader>t :CtrlPBufTagAll<CR>
   nnoremap <leader>f :CtrlPCurWD<CR>
   "nnoremap <leader>f :CtrlPCurFile<CR>
   nnoremap <leader>b :CtrlPBuffer<CR>
endif

if index(s:gEnabledPlugins, 'vim-scripts/YankRing.vim')!=-1
   let g:yankring_max_history= 15
   let g:yankring_persist = 1
   let g:yankring_history_dir = $VIMHOME
   let g:yankring_history_file = 'yankring'

   nnoremap <leader>y :YRShow<CR>
   "nnoremap <leader>ys :YRSearch<CR>
endif

if index(s:gEnabledPlugins, 'ap/vim-buftabline')!=-1
   let g:buftabline_indicators = 1
endif

if index(s:gEnabledPlugins, 'vim-scripts/OmniCppComplete')!=-1
   set tags+=$VIMHOME/tags/cpp_tags
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

"set cursorline                  " cursor line highlighting
"set cursorcolumn                " cursor column highlighting
set virtualedit=block

set list                        " show invisible character
set listchars=tab:>-,trail:-,precedes:<,extends:>
augroup aug:HighlightTrailingWhitespace
   autocmd!
   autocmd BufEnter * 2match Error /\m\(\s\+$\|\([^\t]\)\@<=\t\)/
   autocmd BufLeave * 2match none
augroup end

set clipboard=unnamed           " additionally use (") register as clipboard to (+) register

nnoremap <leader>w :set wrap!<CR>

"}}}
"{{{ Default Keymap Shadow 

" lookup word under cursor in man pages
nnoremap <S-k> <NOP>
" move current lint at the end of previous line
nnoremap <S-j> <NOP>

"}}}
"{{{ Basic Movement 

augroup aug:HelpPageKeyMaps
   autocmd!
   autocmd FileType help nnoremap <buffer> <CR> <C-]>
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
   autocmd FileType * if exists('b:comment_symbol') | execute "inoremap <buffer> <leader>fm <Esc>o". b:comment_symbol . "{{{ <Esc>o" . b:comment_symbol. "}}}<Esc><Up>A" | endif
   autocmd FileType * if exists('b:comment_symbol') | execute "vnoremap <buffer> <leader>fm VV'<O". b:comment_symbol . "{{{ <Esc>'>o" . b:comment_symbol. "}}}<Esc>'<<Up>A" | endif
augroup end

"}}}
"{{{ Tabwidth 

"set expandtab                 " expand tabs to spaces
set tabstop=3                 " number of columns a tab counts
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

nnoremap <leader>n :noh<CR>
execute "vnoremap <leader>r \"hy:%s/<C-r>h/<C-r>h/gc"repeat('<Left>', 4)

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
let &statusline.=' %t'        " file name
let &statusline.=' {%M%R%H}'  " modified/read-only/help-page
let &statusline.=' [%{&ft}]'  "filetype

let &statusline.='%='             " seperator between left and right alignment
if v:version >= 800
   let &statusline.=' [A:%{GetAsyncJobStatus()}]'
endif
let &statusline.=' [%b:0x%B]'     " dec:hex ascii value of char under cursor
let &statusline.=' [%l/%L -- %c]' " current line/num of lines -- current columen
let &statusline.=' (%p%%)'        " current line in percent

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
set wildmode=list:longest     " <Tab> print list of all matches and complete till longest common string
set wildignore+=*.o,*.obj,.git,*.pyc,*~ " Ignore these files when completing

"}}}
"{{{ Save & Restore 

augroup aug:AutoSaveLastSession
   autocmd!
   "autocmd VimEnter * silent! source .vim_last_session
   autocmd QuitPre * execute "mksession! " . $VIMHOME . "/session.last_quit"
augroup end

nnoremap <F2> :execute "source " . $VIMHOME . "/session.last_quit"<CR>

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
"{{{ Project Specific vimrc 

if !empty(glob('.local_vimrc'))
   source .local_vimrc
endif

"}}}
"{{{ Async Command Processor 

if v:version>=800
   " job_start was not working without CB
   function! s:StdOutCB(job, message)
   endfunction

   " job_start was not working without CB
   function! s:StdErrCB(job, message)
   endfunction

   let s:gAsyncJobReturnStatus='*'
   function! s:JobExitCB(job, status)
      "execute 'cbuffer! ' . g:stderr_buffer
      "execute 'caddbuffer ' . s:async_buffer
      echom 'AsyncCmdProcessor: Job exited'
      let s:gAsyncJobReturnStatus = a:status
      let s:gAsyncJobRunning=0
   endfunction

   let s:gAsyncJobRunning=0
   let g:gAsyncBuffer=0
   function! s:AsyncCmdProcessor(...)
      if a:0 == 0
         echom 'AsyncCmdProcessor: no cmd specified'
         return
      endif

      if s:gAsyncJobRunning == 1
         echom 'AsyncCmdProcessor: currently only one job at a time supported'
         return
      endif
      let s:gAsyncJobReturnStatus='*'
      let s:gAsyncJobRunning=1

      let l:current_buffer = bufnr('%')
      let g:gAsyncBuffer = s:CreateLogBuffer('async_buffer')
      execute 'b ' . l:current_buffer

      " concatenate command string
      let l:cmd = ''
      for arg in a:000
         let l:cmd = l:cmd. ' ' . arg
      endfor
      echom l:cmd

      let s:gAsyncJob = job_start(l:cmd, {
               \ 'out_io': 'buffer',
               \ 'out_buf': g:gAsyncBuffer,
               \ 'out_cb': function('s:StdOutCB'),
               \ 'out_msg': '0',
               \ 'err_io': 'buffer',
               \ 'err_buf': g:gAsyncBuffer,
               \ 'err_cb': function('s:StdErrCB'),
               \ 'err_msg': '0',
               \ 'exit_cb': function('s:JobExitCB')
               \})
   endfunction

   " can not be script local because used in statusline
   function! GetAsyncJobStatus()
      if exists('s:gAsyncJob')
         return job_status(s:gAsyncJob) . ':' . s:gAsyncJobReturnStatus
      endif
      return '*:*'
   endfunction

   function! s:KillAsyncJob()
      if exists('s:gAsyncJob')
         let l:dudel = job_stop(s:gAsyncJob)
         execute 'sleep 200ms'
         if job_status(s:gAsyncJob) !=? 'dead'
            echom 'Failed to kill AsyncJob'
         endif
      endif
   endfunction

   let s:fname_filters = [ '\(.\{-}\):\%(\(\d\+\)\%(:\(\d\+\):\)\?\)\?' ]
   " matches current line(from beginning indep of cursor position) against fname_filters
   " the first file name found from beginning of line is opened in window evaluated by 'wincmd w'
   function! s:OpenFirstFileNameMatch()
      " TODO: experimenting <cWORD>
      let l:line = getline('.')

      let l:file_info = []
      let l:file_info =  matchlist(line, s:fname_filters[0])

      if !empty(l:file_info)
         for path in split(&path, ',')    " take first match from path
            if ( empty(path) && !empty(glob(l:file_info[1])) ) || !empty(glob(path . '/' . l:file_info[1]))
               let l:fname = l:file_info[1]
               let l:lnum  = l:file_info[2] == ''? '1' : l:file_info[2]
               let l:cnum  = l:file_info[3] == ''? '1' : l:file_info[3]
               execute 'wincmd w'
               execute 'open ' . l:fname
               call cursor(l:lnum, l:cnum)
               execute 'wincmd p'
               break
            endif
         endfor
      endif
   endfunction

   function! s:CreateLogBuffer(buffer_name)
      let l:buffer_num = bufnr(a:buffer_name, 1)
      execute 'b ' . l:buffer_num
      execute '%d'
      execute 'setlocal buflisted'
      execute 'setlocal buftype=nofile'
      execute 'setlocal noswapfile'
      execute 'setlocal wrap'
      nnoremap <buffer> <CR> :call <SID>OpenFirstFileNameMatch()<CR>
      " go line by line in wrapped lines
      nnoremap <buffer> j gj
      nnoremap <buffer> k gk
      return l:buffer_num
   endfunction

   command! -complete=file -nargs=* Async call s:AsyncCmdProcessor(<f-args>)
   " Space after :Async explicitly wanted ;)
   nnoremap <leader>a :Async 
   nnoremap <leader>ab :execute ':buffer ' . g:gAsyncBuffer<CR>
   nnoremap <leader>ak :call <SID>KillAsyncJob()<CR>
   execute "nnoremap <leader>fg :Async find . -type f -exec grep -nHI  {} +"repeat('<Left>', 6)
endif

"}}}
"{{{ Sandbox 

let s:sandbox_enable = 1
if s:sandbox_enable

" TODO: backup file creation
"       when opening file (of given filetype? maybe start with c/c++) create copy in this file in file_path/.bak/file_name
"       filter file creation somehow, that it does not try to create backups when opening for example /usr/include/*.h

	function! s:LineClearPureBlank()
		execute 'silent! %s#\m^\s\+$##g'
	endfunction
	function! s:LineClearTrailingBlank()
		execute 'silent! %s#\m\s\+$##g'
	endfunction
	function! s:ReduceConsecutiveEmptyLines()
		execute 'silent! %s/\m\(^\n\)\+/\r/g'
	endfunction

	"function! s:LineDeleteCStyleComment()
		"execute 'silent! g#\m^\s\{-}//#d'
	"endfunction

	function! s:LineClearCStyleComment()
		execute 'silent! %s#\m\(.\{-\}\)//.*#\1#g'
	endfunction

	function! s:BlockClearCStyleComment()
		" hack to keep copyright header
		execute 'silent! 2,$s#\m\s\{-\}\/\*[[:alnum:][:blank:][:graph:]\n]\{-\}\*\/\s*##g'
		"execute 'silent! %s#\m^\/\*[[:alnum:][:blank:][:graph:]\n]\{-\}\*\/##g'
	endfunction

	function! s:RemoveCStyleComments()
		call s:LineClearCStyleComment()
		call s:BlockClearCStyleComment()
		call s:LineClearPureBlank()
		call s:LineClearTrailingBlank()
		call s:ReduceConsecutiveEmptyLines()
	endfunction
	command! CC call s:RemoveCStyleComments()

	" TODO: correctly save/restore open/closed folds
	let s:gIsFullScreen = 0
	let s:gSessionFile = $VIMHOME . "/session." . getpid()
	function! s:ToggelFullScreen()
		if s:gIsFullScreen
			let s:gIsFullScreen = 0
			execute "source" s:gSessionFile
		else
			execute "mksession! " s:gSessionFile
			execute "only"
			let s:gIsFullScreen = 1
		endif
	endfunction
	nnoremap <C-f> :call <SID>ToggelFullScreen()<CR>

	augroup aug:CleanUpSessionFile
		autocmd!
		autocmd QuitPre * call delete(s:gSessionFile)
	augroup end


endif

"}}}

"% vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1

