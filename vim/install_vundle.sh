# dotfiles -- vim/install_vundle.sh
# author: johannst

# if INSTALL_DIR changed, it must be also changed in vimrc (lf runtimepath)
INSTALL_DIR=~/.vim/bundle

if [ ! -d $INSTALL_DIR ]; then 
    mkdir $INSTALL_DIR
fi
if [ ! -d $INSTALL_DIR/Vundle.vim ]; then 
    git clone https://github.com/VundleVim/Vundle.vim.git $INSTALL_DIR/Vundle.vim
fi

# install plugins
vim +PluginInstall +qall 
