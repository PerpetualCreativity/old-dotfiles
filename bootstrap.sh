# TODO: detect platform, because karabiner/finicky is only mac
# homebrew
/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim ~/.vim

ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

pip install powerline-shell

brew install neofetch

ln -s ~/.dotfiles/neofetch.conf ~/.config/neofetch/config.conf
ln -s ~/.dotfiles/powerline.json ~/.config/powerline-shell/config.json

if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
    ln -s ~/.dotfiles/.finicky.js ~/.finicky.js
fi

