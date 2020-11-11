# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/Users/ved/.local/bin:/usr/local/opt/libpq/bin:$PATH"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

unsetopt BEEP # stop beeping at me :)

source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme # powerlevel10k

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # zsh syntax highlighting

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh # zsh autosuggestions

eval "$(zoxide init zsh)" # zoxide

export PATH="/usr/local/opt/ruby/bin:$PATH"
bindkey -v

alias quit=exit
alias py=python3
alias todo=todo.sh
alias cd=z

# go stuff
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

