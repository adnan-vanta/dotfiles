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
$HOME/.local/bin/nvim --headless +PlugInstall +qall

# install coc extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
npm install coc-tsserver --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# claude code
npm install -g @anthropic-ai/claude-code


# Create a script that will run on Cursor connection
cat > ~/.install-cursor-extensions.sh << 'EOF'
#!/bin/bash
CURSOR_CLI=$(find ~/.cursor-server/cli/servers/Stable-*/server/bin -name "cursor-server" 2>/dev/null | head -n 1)

if [ -n "$CURSOR_CLI" ]; then
    "$CURSOR_CLI" --install-extension esbenp.prettier-vscode
    "$CURSOR_CLI" --install-extension eamodio.gitlens
    "$CURSOR_CLI" --install-extension typescriptteam.native-preview

    # Remove this script after running once
    rm ~/.install-cursor-extensions.sh
fi
EOF

chmod +x ~/.install-cursor-extensions.sh

# Add to bashrc to run on login
echo '[ -f ~/.install-cursor-extensions.sh ] && ~/.install-cursor-extensions.sh' >> ~/.bashrc
