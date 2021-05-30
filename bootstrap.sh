# Simply comment the lines for things you don't want to install/run

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
export HOMEBREW_NO_AUTO_UPDATE=1 # prevent homebrew from updating itself each package install

# use zsh as the shell
chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# link vim files
ln -s ~/.dotfiles/.vimrc ~/.vimrc
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

# for sharing computer setup
brew install neofetch
ln -s ~/.dotfiles/neofetch.conf ~/.config/neofetch/config.conf

brew install pandoc # powerful file converter
brew install ffmpeg # multimedia processing
brew install zoxide # a smarter cd
brew install todo-txt; cp /usr/local/opt/todo-txt/todo.cfg ~/.todo.cfg  # simple+effective todo list utility
brew install youtube-dl # for downloading videos
brew install coreutils # install gnu coreutils
brew install gh # github cli
brew install so # stackoverflow/stackexchange cli
brew install tldr # simple man pages

brew install zsh-autosuggestions # autosuggestions for zsh
brew install zsh-syntax-highlighting # syntax highlighting for zsh
brew install zoxide # faster + fuzzier `cd`
brew install fzf fd # fuzzy finder and better find

# install my most used languages
brew install cmake python nodejs go haskell-stack
sudo npm install -g typescript

# install language servers (for vim)
brew install gopls
brew install rust-analyzer
sudo npm install -g typescript-language-server
sudo pip3 install 'python-language-server[all]'
ghcup install hls

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install vim # install vim, with options.
    # powerful keyboard remapping
    brew install --cask karabiner-elements
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
    # text expansion
    brew tap federico-terzi/espanso
    brew install espanso
    brew install alacritty # the best terminal emulator...
    brew install --cask figma # ui/ux prototyping and design
    brew install --cask monitorcontrol # control external monitor brightness
    brew install --cask hiddenbar # hide menu items
    brew install --cask grandperspective # a great visual way of analysing disk usage.
    # fonts! specifically, nerd fonts
    brew tap homebrew/cask-fonts
    brew install --cask font-iosevka-nerd-font
    brew install --cask font-victor-mono-nerd-font
fi

source ~/.zshrc # force reload zsh

