" dotfiles -- .vim/vimrc_files/keymaps.vim
" author: johannst

"remap esc button
imap jj <Esc>


"let ArrowDisableMessage = "Arrow Keys disabled! Better learn hjkl ;)"

" Disable arrow keys -- train jklh
" nnoremap <Left>  :echo ArrowDisableMessage<CR>
" nnoremap <Right> :echo ArrowDisableMessage<CR>
" nnoremap <Up>    :echo ArrowDisableMessage<CR>
" nnoremap <Down>  :echo ArrowDisableMessage<CR>
" 
" vnoremap <Left>  :<c-u>echo ArrowDisableMessage<CR>
" vnoremap <Right> :<c-u>echo ArrowDisableMessage<CR>
" vnoremap <Up>    :<c-u>echo ArrowDisableMessage<CR>
" vnoremap <Down>  :<c-u>echo ArrowDisableMessage<CR>
" 
" inoremap <Left>  <c-o>:echo ArrowDisableMessage<CR>
" inoremap <Right> <c-o>:echo ArrowDisableMessage<CR>
" inoremap <Up>    <c-o>:echo ArrowDisableMessage<CR>
" inoremap <Down>  <c-o>:echo ArrowDisableMessage<CR>


" ctrl-hjkl move in insert mode
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>


" ctrl-jk movement in command window
cnoremap <c-h> <Left>
cnoremap <c-j> <Down>
cnoremap <c-k> <Up>
cnoremap <c-l> <Right>


" navigate between different splits 
map <c-Down>  <c-w>j
map <c-Up>    <c-w>k
map <c-Right> <c-w>l
map <c-Left>  <c-w>h
map <c-j>     <c-w>j
map <c-k>     <c-w>k
map <c-l>     <c-w>l
map <c-h>     <c-w>h

   
" navigate between different Tabs
nnoremap <S-Left>  :tabprev<CR>
nnoremap <S-Right> :tabnext<CR>
nnoremap <S-h>     :tabprev<CR>
nnoremap <S-l>     :tabnext<CR>


" ctrl-ae jump to line start/end 
nnoremap <c-a> 0
nnoremap <c-e> $
inoremap <c-a> <c-o>0
inoremap <c-e> <c-o>$
vnoremap <c-a> 0
vnoremap <c-e> $


" Shortcut to toggle relative numbering mode
nnoremap <c-n> :call ToggleRelativeNumber()<CR>


" Open BufferExplorer
nnoremap <C-b> :call BufExplorer()<CR>


" invoke grep and print output into current buffer
nnoremap <C-g> :read !grep -nI 
