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
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# neovim
install neovim --HEAD
# link init.vim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/

# link git config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# link alacritty config
ln -s ~/.dotfiles/.alacritty.yml ~/.alacritty.yml

install \
    pandoc \
    ffmpeg \
    zoxide \
    youtube-dl \
    gh \
    so \
    tldr \
    \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zoxide \
    fzf fd

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
    # install zathura and set up
    brew install girara --HEAD
    brew install zathura --HEAD
    brew install zathura-pdf-poppler
    mkdir -p $(brew --prefix zathura)/lib/zathura
    ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
    ln -s ~/.dotfiles/zathurarc ~/.config/zathura/zathurarc
    # powerful keyboard remapping
    brew install --cask karabiner-elements
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

    brew install --cask iterm2 # the best terminal emulator...
    brew install --cask firefox
    brew install --cask figma \
        monitorcontrol \
        grandperspective
    # fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-victor-mono-nerd-font
fi

source ~/.zshrc # force reload zsh

