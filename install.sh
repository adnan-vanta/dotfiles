#!/bin/bash

cp bash_profile ~/.bash_profile
cp tmux.conf ~/.tmux.conf

# vim
# install Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir ~/.vim/{_tmp,backup,colors}
cp vimrc ~/.vimrc
cp sierra ~/.vim/colors/sierra.vim
vim +PlugInstall +qall
