" hi clear CursorLine
" augroup CLClear
"     autocmd! ColorScheme * hi clear CursorLine
" augroup END

" Highlight color of current line 
hi CursorLineNR cterm=bold ctermfg=226 
augroup CLNRSet
    autocmd! ColorScheme * hi CursorLineNR cterm=bold ctermfg=226
augroup END
