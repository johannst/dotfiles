" dotfiles -- .vim/vimrc_files/functions.vim
" author: johannst

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
