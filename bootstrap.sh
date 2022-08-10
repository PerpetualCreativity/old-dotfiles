#!/usr/bin/env sh
if [ "$(uname -s)" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
    export HOMEBREW_NO_AUTO_UPDATE=1 # prevent homebrew from updating itself each package install
    install () {
        brew install "$@"
    }
elif [ -f /etc/debian_version ]; then
    sudo apt update && sudo apt upgrade
    install () {
        sudo apt install "$@"
    }
else
    echo "this script only runs on macOS and Debian-based Linux distributions"
    exit
fi

# use zsh as the shell
chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# install the vim-plug plugin manager
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# neovim
install neovim --HEAD
# link init.vim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/

# link git config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# link alacritty config
ln -s ~/.dotfiles/.alacritty.yml ~/.alacritty.yml

install \
    pandoc \ # powerful file converter
    ffmpeg \ # multimedia processing
    zoxide \ # a smarter cd
    youtube-dl \ # for downloading videos
    gh \ # github cli
    so \ # stackoverflow/stackexchange cli
    tldr \ # simple man pages
    \
    zsh-autosuggestions \ # autosuggestions for zsh
    zsh-syntax-highlighting \ # syntax highlighting for zsh
    zoxide \ # faster + fuzzier `cd`
    fzf fd # fuzzy finder and better find

# install my most used languages
install cmake python nodejs go haskell-stack racket
sudo npm install -g typescript

# install language servers (for vim)
install gopls rust-analyzer lua-language-server
sudo npm install -g typescript-language-server
sudo pip3 install 'python-lsp-server[all]'
ghcup install hls
raco pkg install racket-langserver

if [ "$(uname -s)" = "Darwin" ]; then
    # powerful keyboard remapping
    brew install --cask karabiner-elements
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

    brew install --cask iterm2 # the best terminal emulator...
    brew install --cask figma \ # ui/ux prototyping and design
        monitorcontrol \ # control external monitor brightness
        grandperspective # a great visual way of analysing disk usage.
    # fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-victor-mono-nerd-font
fi

source ~/.zshrc # force reload zsh

