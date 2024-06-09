if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" 
    export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
    export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    export PATH="/usr/local/opt/ruby/bin:$PATH"
    export PATH="/Users/ved/.local/bin:/usr/local/opt/libpq/bin:$PATH"
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
    export JAVA_HOME=$(/usr/libexec/java_home -v 19.0.1)
fi
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.mix/escripts:$PATH"
export PATH="$HOME/.zig:$PATH"
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$HOME/.dotfiles/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 19.0.1)

# install zsh completions from homebrew-installed utilities
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

unsetopt BEEP # stop beeping at me :)

eval "$(zoxide init zsh)" # zoxide

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

bindkey -v
export EDITOR=hx
export CLICOLOR=true
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt extended_history

alias -g ...='../..'
alias -g ....='../../..'
alias py=python3
alias cd=z
alias exa="exa --tree --sort=modified --reverse --icons --long --git --no-permissions --no-filesize --no-user --no-time --git-ignore"
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias vim=nvim
alias vlime='sbcl --load ~/.local/share/nvim/plugged/vlime/lisp/start-vlime.lisp'
notes () { hx ~/notes/$1.md }
alias todo='notes todo'
mkcd () { mkdir $1 && cd $1 }
cls () { cd $1 && ls }
pdf () { zathura $1 &! }
alias -s pdf=pdf
alias h='hx .'
alias phoenix='hx ~/gt/phoenix/vip-scc.wiki/Ved-Thiru.md'
alias ksh='kitty +kitten ssh'

setopt correct # corrections
setopt no_case_glob
# history
setopt extended_history
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_verify

# prompt
setopt prompt_subst
autoload -Uz add-zsh-hook
getgit () {
    psvar[1]=;
    git rev-parse &> /dev/null
    if [ $? -eq 0 ]
    then
        branchname=$(git branch --show-current)
        psvar[1]="$psvar[1]%F{blue}$branchname%f "

        git rev-parse --abbrev-ref @{upstream} &> /dev/null
        if [ $? -eq 0 ]
        then
            unpushed=$(git cherry -v origin/$branchname $branchname | wc -l | sed 's/^ *//')
            if [ $unpushed != "0" ]; then psvar[1]="$psvar[1]%F{blue}↑$unpushed%f "; fi
            unpulled=$(git cherry -v $branchname origin/$branchname | wc -l | sed 's/^ *//')
            if [ $unpulled != "0" ]; then psvar[1]="$psvar[1]%F{blue}↓$unpulled%f "; fi
        else
            psvar[1]="$psvar[1]%F{red}⇡⇣%f "
        fi

        added=$(git diff --cached --name-only | wc -l | sed 's/^ *//')
        if [ $added != "0" ]; then psvar[1]="$psvar[1]%F{green}+$added%f "; fi

        modified=$(git ls-files --modified --exclude-standard | wc -l | sed 's/^ *//')
        if [ $modified != "0" ]; then psvar[1]="$psvar[1]%F{yellow}!$modified%f "; fi

        others=$(git ls-files --others --exclude-standard | wc -l | sed 's/^ *//')
        if [ $others != "0" ]; then psvar[1]="$psvar[1]%F{magenta}?$others%f "; fi

        deleted=$(git ls-files --deleted --exclude-standard | wc -l | sed 's/^ *//')
        if [ $deleted != "0" ]; then psvar[1]="$psvar[1]%F{red}X$deleted%f "; fi

        stash=$(git stash list | wc -l | sed 's/^ *//')
        if [ $stash != "0" ]; then psvar[1]="$psvar[1]%F{white}<$stash%f "; fi
    fi
}
add-zsh-hook precmd getgit
check_bell () {
    if [[ ${TTYIDLE} -gt 15 ]]; then
        tput bel
    fi
}
add-zsh-hook precmd check_bell
# not using %v, and using $psvar and setopt promptsubst instead,
# allows us to use escape sequences in psvar
PROMPT='%F{magenta}%n%f %F{cyan}%~%f $psvar[1]%(0?.%F{green}.%F{red})%B>%b%f '
RPROMPT='%(0?..%F{red}%?%f)'

# The following lines were added by compinstall

zstyle ':completion:*' auto-description '%d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-/]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/vulcan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

sourceif () { [ -f $1 ] && source $1 }
if [ "$(uname -s)" = "Darwin" ]; then
    sourceif ~/.fzf.zsh
    sourceif "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    sourceif "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [ -f /etc/debian_version ]; then
    sourceif /usr/share/doc/fzf/examples/key-bindings.zsh
    sourceif /usr/share/doc/fzf/examples/completion.zsh
    sourceif /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    sourceif /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /etc/fedora-release ]; then
    sourceif /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    sourceif /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

[ -f "/Users/vulcan/.ghcup/env" ] && source "/Users/vulcan/.ghcup/env" # ghcup-env
