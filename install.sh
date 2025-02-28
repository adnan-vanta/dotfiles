#!/bin/bash
set -e

cp bash_profile ~/.bash_profile
cp tmux.conf ~/.tmux.conf

# Install neovim
mkdir -p ~/.local
cd ~/.local
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
mkdir -p ~/.local/bin
ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim
cd -

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p ~/.config/nvim/{_tmp,backup,colors}
cp vimrc ~/.config/nvim/init.vim
cp sierra ~/.config/nvim/colors/sierra.vim
# $HOME/.local/bin/nvim +PlugInstall +qall
# $HOME/.local/bin/nvim +CocInstall coc-tsserver +qall
