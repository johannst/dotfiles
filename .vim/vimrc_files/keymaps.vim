" dotfiles -- .vim/vimrc_files/keymaps.vim
" author: johannst

" set leader key
let mapleader=","

" re-source .vimrc
map <leader>v :source ~/.vimrc<CR>

"remap esc button
imap jj <Esc>

" prevent quit accidentlty 
map :q :bd
map :qa :bd
map :wq :w<CR>:bd
noremap <leader>q :q<CR>

" re-adjust indentation
map <leader>f mzgg=G`z

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
map <C-Down>  <c-w>j
map <C-Up>    <c-w>k
map <C-Right> <c-w>l
map <C-Left>  <c-w>h


" resize splits
map <C-j>     <C-w>5-
map <C-k>     <C-w>5+
map <C-l>     <C-w>5<
map <C-h>     <C-w>5>

   
" navigate between different buffers 
nnoremap <S-Left>  :bprevious<CR>
nnoremap <S-Right> :bnext<CR>


" ctrl-ae jump to line start/end 
nnoremap <C-a> 0
nnoremap <C-e> $
inoremap <C-a> <c-o>0
inoremap <C-e> <c-o>$
vnoremap <C-a> 0
vnoremap <C-e> $


" Shortcut to toggle relative numbering mode
nnoremap <c-n> :call ToggleRelativeNumber()<CR>

" add a marker fold snippet (for C/C++)
nnoremap <C-f> o//{{{ <Esc>o//}}}<Esc><Up>A
imap <C-f> <ESC><C-f>
" only works with v-block (not v-line)
vnoremap <C-f> VV'<O//{{{ <Esc>'>o//}}}<Esc>'<<ESC><Up>A 

" substitute selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" +-----------------+
" | Plugin specific |
" +-----------------+
" Open BufferExplorer
nnoremap <C-b> :call BufExplorer()<CR>

" Toggle Tagbar 
nnoremap <leader>t :TagbarToggle<CR>

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q --language-force=C++ .<CR>
