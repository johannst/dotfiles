# dotfiles -- .vim/install_vundle.sh
# author: johannst
# vundle: https://github.com/VundleVim/Vundle.vim

# if INSTALL_DIR changed, it must be also changed in .vim/vimrc_files/vundle.vim
INSTALL_DIR=~/.vim/bundle

if [ ! -d $INSTALL_DIR ]; then 
    mkdir $INSTALL_DIR
fi
if [ ! -d $INSTALL_DIR/Vundle.vim ]; then 
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
