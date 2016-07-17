" dotfiles -- .vim/vimrc_files/plugin_config.vim
" author: johannst


" +----------------------------+
" | Vim-Airline                |
" +----------------------------+
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
     let g:airline_symbols = {}
endif


" +----------------------------+
" | Tagbar                     |
" +----------------------------+
let g:tagbar_ctags_bin='/u/jstolp/apps/bin/ctags'
"let g:tagbar_ctags_bin='/home/johannst/apps/bin/ctags'


" +----------------------------+
" | OmniCppComplete            |
" +----------------------------+
" add tags
" set tags+=~/.vim/tags/cpp_tags

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
