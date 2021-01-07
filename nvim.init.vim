" dotfiles -- nvim.init.vim
" author: johannst

" {{{ Basic vim

if !exists('&mapleader')
    let mapleader=" "
endif

" disable preview window in completion
set completeopt-=preview

" allow modified buffers in the background
set hidden

" make cmdprompt 2 lines high -> used for echodoc to display signature
set cmdheight=2

" enable mouse
set mouse=a

" render `listchars` chars
set list
set listchars=tab:>-,trail:-

" highlight search results
set hlsearch

" }}}
" {{{ Plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'

call plug#end()

" }}}
" {{{ LanguageClient

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rust-analyzer'],
    \ 'cpp': ['clangd', '--completion-style=detailed'],
    \ 'c': ['clangd', '--completion-style=detailed'],
    \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = "fzf"

function ConfigureLSP()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

  " set LSP formatting for 'gq'
  set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
endfunction()

augroup LSP
  autocmd!
  autocmd FileType rust,c,cpp call ConfigureLSP()
augroup END

augroup LSP_autofmt
  autocmd!
  autocmd BufWritePre *.rs,*.h,,*.c,*.hh,*.cc,*.hpp,*.cpp call LanguageClient#textDocument_formatting()
augroup END

" }}}
" {{{ Deoplete

let g:deoplete#enable_at_startup = 1

" }}}
" {{{ Echodoc

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" }}}
