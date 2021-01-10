# Simply comment the lines for things you don't want to install/run
#
# Things I haven't added yet:
# menu-bar-splitter - https://github.com/jwhamilton99/menu-bar-splitter
# useful? vim +PluginInstall +qall
# also, need to add the fix to the vim linking problem
# as specified here:
# https://apple.stackexchange.com/a/362840

# homebrew
/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
export HOMEBREW_NO_AUTO_UPDATE=1 # prevent homebrew from updating itself each package install

# use zsh as the shell
chsh -s $(which zsh)
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# link vim files
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.vim ~/.vim
# install the vundle plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link git config
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# link powerlevel10k config
# if you ever feel like changing this, run `p10k configure` and a config wizard will pop up
brew install romkatv/powerlevel10k/powerlevel10k
ln -s ~/dotfiles/.p10k.zsh ~/.p10k.zsh

# for sharing computer setup
brew install neofetch
ln -s ~/.dotfiles/neofetch.conf ~/.config/neofetch/config.conf

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

brew install cmake python nodejs # install my most-used langauges :)

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install vim # install vim, with options.
    # powerful keyboard remapping
    brew cask install karabiner-elements
    ln -s ~/.dotfiles/karabiner.json ~/.config/karabiner/karabiner.json
    # text expansion
    brew tap federico-terzi/espanso
    brew install espanso
    brew install alacritty # the best terminal emulator...
    brew cask install docker # containerisation...
    brew cask install figma # ui/ux prototyping and design
    brew cask install monitorcontrol # control external monitor brightness
    brew cask install hiddenbar # hide menu items
    brew cask install wireshark # network protocol analyser
    brew cask install obs # screen capturing/recording
    brew cask install michaelvillar-timer # small timer utility
    brew cask install iglance # menu bar monitor
    brew cask install grandperspective # a great visual way of analysing disk usage.
    # fonts! specifically, nerd fonts
    brew tap homebrew/cask-fonts
    brew cask install font-fira-code-nerd-font
    brew cask install font-iosevka-nerd-font
    brew cask install font-source-code-pro-nerd-font
    brew cask install font-victor-mono-nerd-font
fi

source ~/.zshrc # force reload zsh

