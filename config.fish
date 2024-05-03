function fish_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_color brblack
    echo -sn (set_color magenta) $USER (set_color brblack) '@' (set_color green) (prompt_hostname) ' ' (set_color cyan) (prompt_pwd) (fish_git_prompt)
    if fish_is_root_user
        echo -n (set_color red --bold)' $ '
    else
        echo -n (set_color blue)' > '
    end
    set_color normal
end

function fish_right_prompt
    set -l last_status $status
    if test $last_status -ne 0
        echo (set_color red --bold)"[$last_status]"(set_color normal)
    end
end

function fish_greeting
    switch (uname)
        case FreeBSD
            set -f fortune_files hitchhiker discworld 5% freebsd-tips
        case Darwin
            set -f fortune_files hitchhiker discworld
    end
    if test -z $SUPPRESS_GREETING
        fortune $files | fmt -c -w 120
    end
end

if status is-interactive
    alias h='hx .'
    alias ksh='kitty +kitten ssh'
    function mkcd
        mkdir $argv[1]; and cd argv[1]
    end
    function cls
        cd $argv[1]; and ls
    end
    function notes
        hx "~/notes/$argv[1].md"
    end
    zoxide init fish --cmd cd | source
    fish_config theme choose "Rosé Pine Dawn"
end

# opam configuration
source /Users/vulcan/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
