# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
export HOMEBREW_NO_AUTO_UPDATE=1 # prevent homebrew from updating itself each package install

# use zsh as the shell
chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# install the vundle plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# neovim
brew install neovim --HEAD
# link init.vim
ln -s ~/.dotfiles/init.vim ~/.config/nvim/

# link git config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# link alacritty config
ln -s ~/.dotfiles/.alacritty.yml ~/.alacritty.yml

brew install \
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

# install fzf's zsh plugin
/usr/local/opt/fzf/install

# install my most used languages
brew install cmake python nodejs go haskell-stack racket
sudo npm install -g typescript

# install language servers (for vim)
brew install gopls rust-analyzer
sudo npm install -g typescript-language-server
sudo pip3 install 'python-lsp-server[all]'
ghcup install hls
raco pkg install racket-langserver

if [[ "$OSTYPE" == "darwin"* ]]; then
    # powerful keyboard remapping
    brew install --cask karabiner-elements
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

    brew install iterm2 # the best terminal emulator...
    brew install --cask figma \ # ui/ux prototyping and design
        monitorcontrol \ # control external monitor brightness
        grandperspective # a great visual way of analysing disk usage.
    # fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-victor-mono-nerd-font
fi

source ~/.zshrc # force reload zsh

