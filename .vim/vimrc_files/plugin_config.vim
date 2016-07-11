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

