" dotfiles -- .vim/vimrc_files/vundle.vim
" author: johannst

" to install plugins open vim and run :PluginInstall from within vim OR
" vim +PluginInstall +qall from cmd line

filetype off         " necessary for vundle!!!
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'jlanzarotta/bufexplorer'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'majutsushi/tagbar'

Plugin 'kien/ctrlp.vim'

" c++ modifief headers: http://www.vim.org/scripts/script.php?script_id=2358
"Plugin 'vim-scripts/OmniCppComplete'

call vundle#end()         
