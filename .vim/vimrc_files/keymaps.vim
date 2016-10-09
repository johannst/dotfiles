" dotfiles -- .vim/vimrc_files/keymaps.vim
" author: johannst

" set leader key
"execute "set <M-s>=\es"
let mapleader="S"

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

" navigate between different splits 
map <C-Down>  <C-w>j
map <C-Up>    <C-w>k
map <C-Right> <C-w>l
map <C-Left>  <C-w>h
map <C-j>     <C-w>j
map <C-k>     <C-w>k
map <C-l>     <C-w>l
map <C-h>     <C-w>h

" resize splits
"map <C-j>     <C-w>5-
"map <C-k>     <C-w>5+
"map <C-l>     <C-w>5<
"map <C-h>     <C-w>5>

" navigate between different buffers 
nnoremap <S-Left>  :bprevious<CR>
nnoremap <S-Right> :bnext<CR>
nnoremap <S-h>  :bprevious<CR>
nnoremap <S-l>  :bnext<CR>

" ctrl-ae jump to line start/end 
nnoremap <C-a> 0
nnoremap <C-e> $
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
vnoremap <C-a> 0
vnoremap <C-e> $
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Shortcut to toggle relative numbering mode
nnoremap <C-n> :call ToggleRelativeNumber()<CR>

" add a marker fold snippet (for C/C++)
nnoremap <C-f> o//{{{ <Esc>o//}}}<Esc><Up>A
imap <C-f> <ESC><C-f>
" only works with v-block (not v-line)
vnoremap <C-f> VV'<O//{{{<Esc>'>o//}}}<Esc>'<<ESC><Up>A 

" substitute selection
vnoremap <C-r> "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>

" yank/paste into/from register
vnoremap <C-c> "ay
inoremap <C-v> <C-r>a
cnoremap <C-v> <C-r>a

" +-----------------+
" | Plugin specific |
" +-----------------+
" Open BufferExplorer
nnoremap <C-b> :call BufExplorer()<CR>

" Toggle Tagbar 
nnoremap <leader>t :TagbarToggle<CR>

" build tags of your own project with Ctrl-F12
map <C-t> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q --language-force=C++ .<CR>
