# homebrew
/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim ~/.vim

ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh

brew install romkatv/powerlevel10k/powerlevel10k

brew install neofetch

ln -s ~/.dotfiles/neofetch.conf ~/.config/neofetch/config.conf
ln -s ~/.dotfiles/powerline.json ~/.config/powerline-shell/config.json

if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
fi

