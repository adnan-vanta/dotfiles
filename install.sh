#!/bin/bash
set -e

cp bash_profile ~/.bash_profile
cp tmux.conf ~/.tmux.conf

# Install neovim
NVIM_VERSION=0.10.4
sudo apt-get install -y libfuse2
curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage
chmod a+x $HOME/bin/nvim

if [ ! -f "$HOME/bin/nvim" ]; then
  echo "Neovim installation failed"
  exit 1
fi

# install Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir ~/.config/nvim/{_tmp,backup,colors}
cp vimrc ~/.config/nvim/init.vim
cp sierra ~/.config/nvim/colors/sierra.vim
nvim +PlugInstall +qall
nvim +CocInstall coc-tsserver +qall
