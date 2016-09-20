" dotfiles -- .vim/vimrc_files/highlights.vim
" author: johannst

" hi clear CursorLine
" augroup CLClear
"     autocmd! ColorScheme * hi clear CursorLine
" augroup END

" Highlight color of current line 
hi CursorLineNR cterm=bold ctermfg=226 
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermfg=226
augroup END

" Highlight status line
hi StatusLine ctermbg=38 ctermfg=0 cterm=NONE term=NONE gui=NONE
"hi StatusLineNC ctermbg=81 ctermfg=0

" matching brackets
"hi MatchParen cterm=underline ctermbg=141 ctermfg=yellow
hi MatchParen cterm=underline ctermbg=141 ctermfg=yellow
