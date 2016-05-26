# dotfiles

- **.vim/colors**:
	- solarized: https://github.com/altercation/solarized
	- buddy    : https://github.com/DrSpatula/vim-buddy
	- gruvbox  : https://github.com/morhetz/gruvbox
	- pride    : https://github.com/lyxell/pride.vim
	- scheakur : https://github.com/scheakur/vim-scheakur

- **.vim/available_plugins**:
    - bufexplorer : https://github.com/jlanzarotta/bufexplorer

- **Enabling Plugin**
    - first plugin:
        # create folder .vim/plugin
        # create folder .vim/doc
        # link plugin from .vim/available_plugins into .vim/plugin
        # link doc from .vim/available_plugins into .vim/doc
    - not first plugin (.vim/plugin .vim/doc exist):
        # link plugin from .vim/available_plugins into .vim/plugin
        # link doc from .vim/available_plugins into .vim/doc
