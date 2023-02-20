#!/bin/zsh

# determine theme to switch to
# send usrsig1 to helix
old='latte'
new='mocha'

sw () {
  ex - $2 "+%s/${1/THEME/$old}/${1/THEME/$new}" "+x"
}

sw 'theme = "catppuccin_THEME"' ~/.config/helix/config.toml
for pid in `pgrep hx`; do kill -USR1 $pid; done

sw 'set -g @catppuccin_flavour '\''THEME'\' ~/.tmux.conf

sw 'colors: *THEME' ~/.alacritty.yml
