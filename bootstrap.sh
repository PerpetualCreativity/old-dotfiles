#!/usr/bin/env zsh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
export HOMEBREW_NO_AUTO_UPDATE=1 # prevent homebrew from updating itself each package install

# use zsh as the shell
chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# install the vim-plug plugin manager
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# neovim
brew install neovim --HEAD
# link init.vim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/

# link git config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# link alacritty config
ln -s ~/.dotfiles/.alacritty.yml ~/.alacritty.yml

brew install \
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
brew install cmake python nodejs go haskell-stack racket
sudo npm install -g typescript

# install language servers (for vim)
brew install gopls rust-analyzer lua-language-server
sudo npm install -g typescript-language-server
sudo pip3 install 'python-lsp-server[all]'
ghcup install hls
raco pkg install racket-langserver

if [ "$(uname -s)" = "Darwin" ]; then
    # powerful keyboard remapping
    brew install --cask karabiner-elements
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

    brew install --cask iterm2 # the best terminal emulator...
    brew install --cask firefox
    brew install --cask figma \
        monitorcontrol \
        betterdisplay \
        topnotch \
        grandperspective
    # fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-victor-mono-nerd-font
fi

source ~/.zshrc # force reload zsh

