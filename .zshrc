export PATH="/Users/ved/.local/bin:/usr/local/opt/libpq/bin:$PATH"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

unsetopt BEEP # stop beeping at me :)

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # zsh syntax highlighting

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh # zsh autosuggestions

eval "$(zoxide init zsh)" # zoxide

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

export PATH="/usr/local/opt/ruby/bin:$PATH"
bindkey -v

export PATH=$PATH:$HOME/go/bin

export PATH=$PATH:$HOME/.cargo/bin

alias quit=exit
alias py=python3
alias todo=todo.sh
alias cd=z
alias ds=dstask
alias exa="exa --tree --sort=modified --reverse --icons --long --git --no-permissions --no-filesize --no-user --no-time --git-ignore"
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias vim=nvim

# prompt
setopt promptsubst
autoload -Uz add-zsh-hook
getgit () {
    psvar[1]=;
    git rev-parse &> /dev/null
    if [ $? -eq 0 ]
    then
        branchname=$(git branch --show-current)
        psvar[1]="$psvar[1]%F{blue}$branchname%f "

        commits=$(git cherry -v | wc -l | sed 's/^ *//')
        if [ $commits != "0" ]; then psvar[1]="$psvar[1]%F{blue}↑$commits%f "; fi

        added=$(git diff --cached --name-only | wc -l | sed 's/^ *//')
        if [ $added != "0" ]; then psvar[1]="$psvar[1]%F{green}+$added%f "; fi

        modified=$(git ls-files --modified --exclude-standard | wc -l | sed 's/^ *//')
        if [ $modified != "0" ]; then  psvar[1]="$psvar[1]%F{yellow}!$modified%f "; fi

        others=$(git ls-files --others --exclude-standard | wc -l | sed 's/^ *//')
        if [ $others != "0" ]; then psvar[1]="$psvar[1]%F{magenta}?$others%f "; fi

        deleted=$(git ls-files --deleted --exclude-standard | wc -l | sed 's/^ *//')
        if [ $deleted != "0" ]; then psvar[1]="$psvar[1]%F{red}X$deleted%f "; fi
    fi
}
add-zsh-hook precmd getgit
# not using %v, and using $psvar and setopt promptsubst instead,
# allows us to use escape sequences in psvar
PROMPT='%F{cyan}%~%f $psvar[1]%(0?.%F{green}.%F{red})%B>%b%f '
RPROMPT='%(0?..%F{red}%?%f)'

