# PerpetualCreativity's dotfiles
These are my dotfiles.

## Install
0. `git clone https://github.com/PerpetualCreativity/dotfiles.git ~/.dotfiles`
1. `sh ~/.dotfiles/bootstrap.sh`
2. `vim ~/.vimrc` and then run `:source %` and `:PluginInstall`
3. `cd ~/.vim/bundle/YouCompleteMe; python3 install.py --all`

## To-do

Combine `.vimrc` (vim) and `init.vim` (neovim) to avoid duplication (using `if has('nvim')`).

