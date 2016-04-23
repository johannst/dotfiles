" Split Window and scroll down
fu! SplitScroll()
    :wincmd v
    :wincmd w
    execute "normal! \<C-d>"
    :set scrollbind
    :wincmd w
    :set scrollbind
endfu

" toggle relative line number mode
function! ToggleRelativeNumber()           
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc  
