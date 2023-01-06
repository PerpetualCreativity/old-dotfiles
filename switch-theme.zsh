#!/bin/zsh

# determine theme to switch to
old='latte'
new='mocha'

sw () {
  sed "s/${1/THEME/$old}/${helix/THEME/$new}/" $2 > $2
}

sw 'theme = "catppuccin_THEME"' ~/.config/helix/config.toml
sw 'set -g @catppuccin_flavour '\''THEME'\' ~/.tmux.conf
sw 'colors: *THEME' ~/.alacritty.yml
