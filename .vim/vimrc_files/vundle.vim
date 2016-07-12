" dotfiles -- .vim/vimrc_files/vundle.vim
" author: johannst

" to install plugins open vim and run :PluginInstall

filetype off         " necessary for vundle!!!
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'


Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'majutsushi/tagbar'


call vundle#end()         
