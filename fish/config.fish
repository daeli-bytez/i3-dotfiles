status is-interactive; or return

set -g fish_greeting ""

functions -e ls grep fgrep egrep diff .. ... .... .....

if command -v fastfetch >/dev/null
    fastfetch
end

function fish_prompt
    set -l cmd_idx (history | count)

    set -l c_blue (set_color 89b4fa)
    set -l c_white (set_color ffffff)
    set -l c_reset (set_color normal)

    printf '┌──(%s@%s)─[%s]\n' $USER $hostname (date "+%a %H:%M")

    printf '├──[%s]' (prompt_pwd -d 0)

    if command -v git >/dev/null
        set -l branch (git branch --show-current 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
        if test -n "$branch"
            printf '─[⑂ %s]' $branch
        end
    end

    printf '─[cmd %s]\n' $cmd_idx

    if fish_is_root_user
        printf '└──%s#%s ' $c_white $c_reset
    else
        printf '└──%s»%s ' $c_blue $c_reset
    end
end

set -g fish_complete_inline 1
set -g fish_ambiguous_completions 1

abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a ..... 'cd ../../../..'
abbr -a pacup 'sudo pacman -Syu'
abbr -a pacin 'sudo pacman -S'
abbr -a l 'ls -lah --color=auto'
abbr -a c clear
